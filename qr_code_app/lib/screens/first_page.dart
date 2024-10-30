import 'package:flutter/material.dart';
import 'package:qr_code_app/screens/qr_scanner_screen.dart';
import 'package:qr_code_app/screens/sign_in_screen.dart';
import 'package:qr_code_app/screens/signup_screen.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 24, 103, 192),
        elevation: 0,
        title: Text(
          'Xcanners',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // Parte superior com fundo azul e logo de QR Code
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 24, 103, 192),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(60),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.qr_code,
                    size: 100,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'QR Code App',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Parte inferior com fundo branco e botões
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              color: const Color.fromARGB(255, 255, 255, 255),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton(
                    context,
                    'Cadastro',
                    Icons.person_add,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                  ),
                  _buildButton(
                    context,
                    'Login',
                    Icons.login,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPageScreen()),
                      );
                    },
                  ),
                  _buildButton(
                    context,
                    'Leitor QR Code',
                    Icons.qr_code_scanner,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QRCodeScannerPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    BuildContext context,
    String text,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 60),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: const Color.fromARGB(255, 24, 103, 192), width: 2,
          ),
        ),
        elevation: 5,
      ),
      icon: Icon(icon, size: 28, color: const Color.fromARGB(255, 24, 103, 192)),
      label: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 24, 103, 192),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
