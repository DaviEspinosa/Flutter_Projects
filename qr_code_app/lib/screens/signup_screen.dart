import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  // Criando atributos para controle de Texto
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nomeController = TextEditingController();
  final _blocoController = TextEditingController();
  final _numeroApartamentoController = TextEditingController();
  final _cpfController = TextEditingController();
  final _authService = AuthService();

  // Pega o text para cadastrar
  void _signUp() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String nome = _nomeController.text;
    String bloco = _blocoController.text;
    String numeroApartamento = _numeroApartamentoController.text;
    String cpf = _cpfController.text;

    try {
      await _authService.signUp(nome, email, password, bloco, numeroApartamento, cpf);
      // Navegar para a próxima tela ou exibir uma mensagem de sucesso
    } catch (e) {
      // Exibir erro ao usuário
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            TextField(
              controller: _blocoController,
              decoration: InputDecoration(labelText: 'Bloco'),
              obscureText: true,
            ),
            TextField(
              controller: _numeroApartamentoController,
              decoration: InputDecoration(labelText: 'Número Apartamento'),
              obscureText: true,
            ),
            TextField(
              controller: _cpfController,
              decoration: InputDecoration(labelText: 'CPF'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signUp,
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
