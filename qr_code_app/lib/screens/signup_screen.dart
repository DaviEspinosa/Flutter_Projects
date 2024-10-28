  import 'package:flutter/material.dart';
  import 'package:qr_flutter/qr_flutter.dart';
  import '../services/auth_service.dart';

  class SignUpScreen extends StatefulWidget {
    @override
    _SignUpScreenState createState() => _SignUpScreenState();
  }

  class _SignUpScreenState extends State<SignUpScreen> {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _nomeController = TextEditingController();
    final _blocoController = TextEditingController();
    final _numeroApartamentoController = TextEditingController();
    final _cpfController = TextEditingController();
    final _authService = AuthService();

    String? _cpfForQrCode;
    bool _isLoading = false;

    void _signUp() async {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      String nome = _nomeController.text.trim();
      String bloco = _blocoController.text.trim();
      String numeroApartamento = _numeroApartamentoController.text.trim();
      String cpf = _cpfController.text.trim();

      if (email.isEmpty || password.isEmpty || nome.isEmpty || cpf.isEmpty) {
        _showErrorDialog('Por favor, preencha todos os campos obrigatórios.');
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        await _authService.signUp(
            nome, email, password, bloco, numeroApartamento, cpf);
        _clearFields();
      } catch (e) {
        _showErrorDialog(e.toString());
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }

    void _clearFields() {
      _emailController.clear();
      _passwordController.clear();
      _nomeController.clear();
      _blocoController.clear();
      _numeroApartamentoController.clear();
      _cpfController.clear();
      setState(() {
        _cpfForQrCode = null; // Limpa o QR Code ao limpar os campos
      });
    }

    void _showErrorDialog(String message) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Erro'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    }

    @override
    void initState() {
      super.initState();
      // Adiciona um listener ao controlador do CPF
      _cpfController.addListener(() {
        setState(() {
          _cpfForQrCode = _cpfController.text.trim(); // Atualiza o QR Code conforme o CPF é digitado
        });
      });
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
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
              ),
              TextField(
                controller: _blocoController,
                decoration: InputDecoration(labelText: 'Bloco'),
              ),
              TextField(
                controller: _numeroApartamentoController,
                decoration: InputDecoration(labelText: 'Número Apartamento'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _cpfController,
                decoration: InputDecoration(labelText: 'CPF'),
                // Remova obscureText: true para mostrar o CPF
              ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _signUp,
                      child: Text('Cadastrar'),
                    ),
              SizedBox(height: 20),
              if (_cpfForQrCode != null && _cpfForQrCode!.isNotEmpty)
                Column(
                  children: [
                    Text('QR Code para o CPF'),
                    QrImageView(
                      data: _cpfForQrCode!, // Usa o CPF atualizado
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  ],
                ),
            ],
          ),
        ),
      );
    }

    @override
    void dispose() {
      _emailController.dispose();
      _passwordController.dispose();
      _nomeController.dispose();
      _blocoController.dispose();
      _numeroApartamentoController.dispose();
      _cpfController.dispose();
      super.dispose();
    }
  }
    