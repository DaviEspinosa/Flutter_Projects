import 'package:flutter/material.dart';
import 'package:qr_code_app/screens/first_page.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}



class _SignUpScreenState extends State<SignUpScreen> with WidgetsBindingObserver{
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nomeController = TextEditingController();
  final _blocoController = TextEditingController();
  final _numeroApartamentoController = TextEditingController();
  final _cpfController = TextEditingController();
  final _authService = AuthService();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

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

    // Validação de CPF no formato ###.###.###-##
    RegExp cpfRegex = RegExp(r'^\d{3}\.\d{3}\.\d{3}-\d{2}$');
    if (!cpfRegex.hasMatch(cpf)) {
      _showErrorDialog('CPF inválido. Utilize o formato XXX.XXX.XXX-XX.');
      return;
    }

    // Validação de senha com no mínimo 6 caracteres
    if (password.length < 6) {
      _showErrorDialog('A senha deve ter no mínimo 6 caracteres.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _authService.signUp(nome, email, password, bloco, numeroApartamento, cpf);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, MaterialPageRoute(builder: (context) => FirstPage()),);
              },
            ),
            Text('Cadastro'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildStyledTextField(_nomeController, 'Nome', Icons.person),
            _buildStyledTextField(_emailController, 'Email', Icons.email,
                keyboardType: TextInputType.emailAddress),
            _buildStyledTextField(_passwordController, 'Senha', Icons.lock,
                obscureText: true),
            _buildStyledTextField(_blocoController, 'Bloco', Icons.home),
            _buildStyledTextField(_numeroApartamentoController, 'Número Apartamento',
                Icons.home_work, keyboardType: TextInputType.number),
            _buildStyledTextField(_cpfController, 'CPF', Icons.badge),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 160, vertical: 15),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: _signUp,
                    child: Text(
                      'Cadastrar',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildStyledTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey.shade600),
          prefixIcon: Icon(icon, color: Colors.blue),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: Colors.blue, width: 3.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: Colors.blue, width: 3.5),
          ),
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
