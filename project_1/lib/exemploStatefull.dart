import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); 
}

// A classe MyApp é um widget imutável (StatelessWidget).
// Este widget representa o ponto de entrada do aplicativo.
class MyApp extends StatelessWidget {
  // Construtor da classe MyApp com a keyword const para garantir que o widget seja imutável.
  const MyApp({Key? key}) : super(key: key);

  // O método build é obrigatório em widgets de tipo StatelessWidget.
  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      title: 'Meu App Flutter', 
      home: Scaffold( 
        appBar: AppBar(
          title: const Text('Exemplo de Widget Mutável'), 
        ),
        body: Center(
          child: MeuWidgetMutavel(), // Chama o widget mutável que será exibido na tela.
        ),
      ),
    );
  }
}

// Define um widget mutável (StatefulWidget).
class MeuWidgetMutavel extends StatefulWidget {
  @override
  _MeuWidgetMutavelState createState() => _MeuWidgetMutavelState();
}

// A classe _MeuWidgetMutavelState mantém o estado do MeuWidgetMutavel.
// Esta classe contém a lógica para modificar o estado do widget.
class _MeuWidgetMutavelState extends State<MeuWidgetMutavel> {
  String _texto = 'Pressione o botão para mudar o texto';

  // O método build é obrigatório em classes de estado (State).
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, 
      children: [
        Text(_texto, style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 20), 
        ElevatedButton(
          onPressed: _mudarTexto, // Chama a função _mudarTexto quando o botão é pressionado.
          child: const Text('Mudar Texto'), 
        ),
      ],
    );
  }


  // Ela altera o estado, mudando o texto.
  void _mudarTexto() {
    setState(() {
      // Altera o texto exibido no widget.
      _texto = 'O texto foi alterado!'; 
    });
  }
}
