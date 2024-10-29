// Importações de pacotes necessários.
import 'package:flutter/material.dart';                 // Biblioteca principal do Flutter para criação de interfaces.
import 'package:firebase_auth/firebase_auth.dart';      // Biblioteca para autenticação Firebase.
import 'package:cloud_firestore/cloud_firestore.dart';  // Biblioteca para acessar o Firestore, banco de dados do Firebase.
import 'package:qr_code_app/services/auth_service.dart'; // Serviço de autenticação personalizado.
import 'package:qr_flutter/qr_flutter.dart';            // Biblioteca para gerar códigos QR.
import 'package:qr_code_app/screens/sign_in_screen.dart'; // Tela de login.

class HomePage extends StatelessWidget {
  // Criação de instâncias dos serviços de Firebase para autenticação e Firestore.
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _visitorService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Método para logout
  Future<void> _logout(BuildContext context) async {
    await _auth.signOut(); // Desconecta o usuário.
    Navigator.pushReplacement( // Navega para a tela de login após logout.
      context,
      MaterialPageRoute(builder: (context) => LoginPageScreen()),
    );
  }

  // Método para exibir um diálogo para adicionar visitante
  void _showAddVisitorDialog(BuildContext context) {
    // Controladores para capturar dados inseridos nos campos de texto.
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _cpfController = TextEditingController();

    // Exibe o diálogo com campos para nome e CPF.
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Adicionar Visitante'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController, // Campo para o nome do visitante.
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: _cpfController, // Campo para o CPF do visitante.
                decoration: InputDecoration(labelText: 'CPF'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(); // Fecha o diálogo sem salvar.
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                String name = _nameController.text.trim(); // Obtém o nome do campo.
                String cpf = _cpfController.text.trim();   // Obtém o CPF do campo.

                if (name.isNotEmpty && cpf.isNotEmpty) { // Verifica se os campos não estão vazios.
                  try {
                    await _visitorService.signUpVisitor(name, cpf); // Salva o visitante usando o serviço.
                    Navigator.of(ctx).pop(); // Fecha o diálogo após salvar.
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

  // Método para gerar e salvar um código QR a partir do CPF.
  Future<void> _downloadQRCode(String cpf) async {
    final qrCodeImage = await QrPainter(
      data: cpf,               // Dados que serão convertidos em QR.
      version: QrVersions.auto, // Ajusta o tamanho automaticamente.
      gapless: false,
    ).toImage(300); // Tamanho da imagem do QR Code em pixels.

    // Aqui, implementar a lógica para salvar a imagem.
  }

  // Método que constrói uma lista de visitantes do Firestore.
  Widget _buildVisitorList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('visitors').snapshots(), // Observa alterações em 'visitors'.
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Mostra um loading enquanto carrega.
        }

        final visitors = snapshot.data?.docs ?? []; // Obtém a lista de visitantes do Firestore.

        if (visitors.isEmpty) {
          return Center(child: Text('Nenhum visitante cadastrado.')); // Caso não haja visitantes.
        }

        // Cria a lista de visitantes.
        return ListView.builder(
          itemCount: visitors.length,
          itemBuilder: (ctx, index) {
            final visitor = visitors[index];
            final nome = visitor['nome'];
            final cpf = visitor['cpf'];

            return ListTile(
              title: Text('Nome: $nome'), // Exibe o nome.
              subtitle: Text('CPF: $cpf'), // Exibe o CPF.
              trailing: IconButton(
                icon: Icon(Icons.qr_code),
                onPressed: () => _downloadQRCode(cpf), // Gera QR Code para o CPF.
              ),
            );
          },
        );
      },
    );
  }

  // Método build para construir a interface da tela inicial.
  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser; // Obtém o usuário logado.

    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciamento'),
        leading: Icon(Icons.home), // Ícone de início.
        actions: [
          IconButton(
            icon: Icon(Icons.logout), // Ícone de logout.
            onPressed: () => _logout(context),
          ),
          CircleAvatar( // Exibe a inicial do email do usuário logado.
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
              _showAddVisitorDialog(context); // Exibe o diálogo para adicionar visitante.
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
              Navigator.push( // Navega para a tela de listagem de visitantes.
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
