import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_code_app/screens/home_screen.dart';

// Definição da classe principal LoginPageScreen como um StatefulWidget,
// pois esta tela precisa gerenciar o estado do login.
class LoginPageScreen extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

// Classe de estado para o widget LoginPageScreen
class _LoginPageState extends State<LoginPageScreen> {
  // Instância de FirebaseAuth para realizar a autenticação
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Controladores para capturar as entradas do usuário
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Variável para armazenar e exibir mensagens de erro, caso ocorra falha no login
  String _errorMessage = '';

  // Método de login que tenta autenticar o usuário com email e senha no Firebase
  Future<void> _login() async {
    try {
      // Realiza a autenticação no Firebase com email e senha
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Se o login for bem-sucedido, navega para a tela HomePage e substitui a tela atual
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      // Em caso de erro, exibe uma mensagem de erro
      setState(() {
        _errorMessage = 'Falha no login. Verifique suas credenciais.';
      });
    }
  }

  // Construção da interface da tela de login
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login do Morador'), // Título da barra superior
        leading: Icon(Icons.home), // Ícone do lado esquerdo do AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Espaçamento ao redor do conteúdo
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Alinha o conteúdo ao centro
            children: <Widget>[
              // Campo de entrada para o email do usuário
              Container(
                width: MediaQuery.of(context).size.width * 0.8, // 80% da largura da tela
                child: TextField(
                  controller: _emailController, // Controlador para capturar o email
                  decoration: InputDecoration(
                    labelText: 'Email', // Rótulo para o campo de email
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0), // Bordas arredondadas
                      borderSide: BorderSide(color: Colors.blue, width: 3.5), // Cor e largura da borda
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(color: Colors.blue, width: 3.5),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10), // Espaçamento entre os campos

              // Campo de entrada para a senha do usuário
              Container(
                width: MediaQuery.of(context).size.width * 0.8, // 80% da largura da tela
                child: TextField(
                  controller: _passwordController, // Controlador para capturar a senha
                  decoration: InputDecoration(
                    labelText: 'Senha', // Rótulo para o campo de senha
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(color: Colors.blue, width: 3.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(color: Colors.blue, width: 3.5),
                    ),
                  ),
                  obscureText: true, // Oculta o texto para proteger a senha
                ),
              ),
              SizedBox(height: 20), // Espaçamento entre o campo de senha e o botão de login

              // Botão de login
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 160, vertical: 15), // Tamanho do botão
                  backgroundColor: Colors.blue, // Cor de fundo do botão
                  foregroundColor: Colors.white, // Cor do texto do botão
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50), // Borda arredondada do botão
                  ),
                ),
                onPressed: _login, // Chama a função de login ao clicar
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 16), // Estilo do texto no botão
                ),
              ),

              // Exibe a mensagem de erro, se houver
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0), // Espaçamento acima da mensagem de erro
                  child: Text(
                    _errorMessage, // Exibe a mensagem de erro armazenada
                    style: TextStyle(color: Colors.red), // Cor vermelha para indicar erro
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
