import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_code_app/services/auth_service.dart';
import 'package:qr_code_app/screens/sign_in_screen.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

class HomePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _visitorService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPageScreen()),
    );
  }

  void _showAddVisitorDialog(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _cpfController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Adicionar Visitante'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: _cpfController,
                decoration: InputDecoration(labelText: 'CPF'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(); // Fecha o diálogo sem salvar
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                String name = _nameController.text.trim();
                String cpf = _cpfController.text.trim();
                if (name.isNotEmpty && cpf.isNotEmpty) {
                  try {
                    await _visitorService.signUpVisitor(name, cpf);
                    Navigator.of(ctx).pop(); // Fecha o diálogo após salvar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Visitante adicionado com sucesso!')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erro ao adicionar visitante: $e')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Preencha todos os campos')),
                  );
                }
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveQRCode(BuildContext context, GlobalKey qrKey) async {
    try {
      RenderRepaintBoundary boundary = qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final result = await ImageGallerySaver.saveImage(pngBytes);
      if (result['isSuccess']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('QR Code salvo na galeria com sucesso!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar QR Code na galeria')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar QR Code: $e')),
      );
    }
  }

  void _showQRCodeDialog(BuildContext context, String cpf) {
    final GlobalKey qrKey = GlobalKey();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('QR Code do Visitante'),
          content: RepaintBoundary(
            key: qrKey,
            child: QrImageView(
              data: cpf,
              version: QrVersions.auto,
              size: 200.0,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(); // Fecha o diálogo
              },
              child: Text('Fechar'),
            ),
            TextButton(
              onPressed: () async {
                await _saveQRCode(context, qrKey); // Salva o QR Code na galeria
              },
              child: Text('Baixar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildVisitorList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('visitors').snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final visitors = snapshot.data?.docs ?? [];
        if (visitors.isEmpty) {
          return Center(child: Text('Nenhum visitante cadastrado.'));
        }
        return ListView.builder(
          itemCount: visitors.length,
          itemBuilder: (ctx, index) {
            final visitor = visitors[index];
            final nome = visitor['nome'];
            final cpf = visitor['cpf'];
            return ListTile(
              title: Text('Nome: $nome'),
              subtitle: Text('CPF: $cpf'),
              trailing: IconButton(
                icon: Icon(Icons.qr_code),
                onPressed: () => _showQRCodeDialog(context, cpf),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciamento'),
        leading: Icon(Icons.home),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
          CircleAvatar(
            backgroundColor: Colors.orange,
            child: Text(
              user?.email?.substring(0, 1).toUpperCase() ?? 'D',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(
            leading: Icon(Icons.edit, color: Colors.blue, size: 32),
            title: Text(
              'Adicionar Visitante',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              _showAddVisitorDialog(context);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.list, color: Colors.blue, size: 32),
            title: Text(
              'Listagem de Visitantes',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) => Scaffold(
                  appBar: AppBar(title: Text('Visitantes')),
                  body: _buildVisitorList(context),
                )),
              );
            },
          ),
        ],
      ),
    );
  }
}
