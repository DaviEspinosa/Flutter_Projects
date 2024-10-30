import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRCodeScannerPage extends StatefulWidget {
  @override
  _QRCodeScannerPageState createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String message = "Escaneie um QR Code";
  bool isScanning = true; // Controle de escaneamento

  // Função para verificar se o CPF está registrado no Firestore
  Future<void> _checkAccess(String cpf) async {
    try {
      // Verifica na coleção 'users'
      final userSnapshot = await _firestore
          .collection('users')
          .where('cpf', isEqualTo: cpf)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        // Se encontrado na coleção 'users', navega para a página de acesso autorizado
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AccessResultPage(isAuthorized: true, cpf: cpf),
          ),
        );
      } else {
        // Verifica na coleção 'visitors'
        final visitorSnapshot = await _firestore
            .collection('visitors')
            .where('cpf', isEqualTo: cpf)
            .get();

        if (visitorSnapshot.docs.isNotEmpty) {
          // Se encontrado na coleção 'visitors', navega para a página de acesso autorizado
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AccessResultPage(isAuthorized: true, cpf: cpf),
            ),
          );
        } else {
          // Caso não encontrado em ambas as coleções, navega para a página de acesso não autorizado
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AccessResultPage(isAuthorized: false, cpf: cpf),
            ),
          );
        }
      }
    } catch (e) {
      setState(() {
        message = "Erro ao verificar CPF: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Leitor de QR Code',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.withOpacity(0.7), // Fundo azul fosco
        centerTitle: true, // Centraliza o título
      ),
      body: Stack(
        children: <Widget>[
          MobileScanner(
            onDetect: (BarcodeCapture barcodeCapture) {
              if (isScanning) {
                final String cpf = barcodeCapture.barcodes.first.rawValue ?? "";
                isScanning = false; // Desativa a detecção
                _checkAccess(cpf).then((_) {
                  isScanning = true; // Reativa a detecção após a verificação
                });
              }
            },
          ),
          Center(
            child: Container(
              width: 250, // Largura do quadrado
              height: 250, // Altura do quadrado
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue.withOpacity(0.5),
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Posicione o QR Code aqui",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(  
              child: Container(
                padding: EdgeInsets.all(16), // Adiciona preenchimento ao redor do texto
                decoration: BoxDecoration(
                   color: const Color.fromARGB(255, 18, 42, 62).withOpacity(0.7), // Fundo azul fosco
                  borderRadius: BorderRadius.circular(8), // Bordas arredondadas
                ),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22, // Aumenta o tamanho da fonte da mensagem
                    color: Colors.white, // Muda a cor do texto para branco
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(16), // Adiciona preenchimento ao redor do texto
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 18, 42, 62).withOpacity(0.7), // Fundo azul fosco
                  borderRadius: BorderRadius.circular(8), // Bordas arredondadas
                ),
                child: Text(
                  "Escaneie um QR Code", // Texto que você deseja estilizar
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22, // Tamanho da fonte igual ao título
                    fontWeight: FontWeight.bold, // Negrito
                    color: Colors.white, // Cor do texto
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AccessResultPage extends StatelessWidget {
  final bool isAuthorized;
  final String cpf;

  AccessResultPage({required this.isAuthorized, required this.cpf});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado do Acesso'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isAuthorized ? Icons.check_circle : Icons.error,
              color: isAuthorized ? Colors.green : Colors.red,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              isAuthorized
                  ? "Acesso autorizado para o CPF: $cpf"
                  : "Acesso negado para o CPF: $cpf",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Volta para a tela anterior
              },
              child: Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}
