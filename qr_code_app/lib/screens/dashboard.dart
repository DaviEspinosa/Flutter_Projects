import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_code_app/services/auth_service.dart';
import 'package:qr_code_app/screens/sign_in_screen.dart';
import 'package:path_provider/path_provider.dart'; // Para acessar o diretório de armazenamento
import 'package:screenshot/screenshot.dart';

class HomePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _visitorService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Controlador de captura de tela
  final ScreenshotController _screenshotController = ScreenshotController();

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
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _cpfController,
                decoration: InputDecoration(
                  labelText: 'CPF',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                String name = _nameController.text.trim();
                String cpf = _cpfController.text.trim();
                RegExp cpfRegex = RegExp(r'^\d{3}\.\d{3}\.\d{3}-\d{2}$');
                if (name.isNotEmpty && cpf.isNotEmpty) {
                  if (!cpfRegex.hasMatch(cpf)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('CPF inválido. Utilize o formato XXX.XXX.XXX-XX.')),
                    );
                    return;
                  }
                  try {
                    await _visitorService.signUpVisitor(name, cpf);
                    Navigator.of(ctx).pop();
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

  void _showQRCodeDialog(BuildContext context, String cpf, String name) {
    showDialog(

      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 16,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'QR Code do Visitante',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Screenshot(
                  controller: _screenshotController,
                  child: QrImageView(
                    data: cpf,
                    version: QrVersions.auto,
                    size: 200.0,
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    // Captura a tela e salva a imagem
                    // final directory = await getExternalStorageDirectory();
                    final directory = Directory('storage/emulated/0/Download');
                    final image = await _screenshotController.capture();
                    final filePath = '${directory.path}/QRCode_$name.png';
                    final file = File(filePath);
                    await file.writeAsBytes(image!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('QR Code salvo em: $filePath')),
                    );
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Baixar QR Code'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text('Fechar'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Resto do código permanece o mesmo
Widget _buildVisitorList(BuildContext context) {
  final User? user = _auth.currentUser; // Obter o usuário logado

  // Verifique se o usuário está logado
  if (user == null) {
    return Center(child: Text('Nenhum usuário logado.'));
  }

  return StreamBuilder<QuerySnapshot>(
    stream: _firestore
        .collection('visitors')
        .where('moradorId', isEqualTo: user.uid) // Filtra os visitantes pelo ID do morador
        .snapshots(),
    builder: (ctx, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasError) {
        return Center(child: Text('Erro ao carregar visitantes: ${snapshot.error}'));
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
          return Card(
            margin: EdgeInsets.symmetric(vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(Icons.person, color: Colors.blueAccent),
              title: Text('Nome: $nome'),
              trailing: IconButton(
                icon: Icon(Icons.qr_code, color: Colors.blueAccent),
                onPressed: () => _showQRCodeDialog(context, cpf, nome),
              ),
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
                MaterialPageRoute(
                    builder: (ctx) => Scaffold(
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
