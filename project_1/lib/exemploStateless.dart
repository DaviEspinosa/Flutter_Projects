import 'package:flutter/material.dart'; // Importa o pacote Flutter para usar seus componentes.

void main() {
  runApp(const MyApp()); // O método main é o ponto de entrada da aplicação. Ele executa o widget raiz MyApp.
}

// A classe MyApp é um widget imutável (StatelessWidget).
// StatelessWidget significa que o widget não terá seu estado alterado após ser construído.
class MyApp extends StatelessWidget {
  // O construtor da classe MyApp usa a palavra-chave const para garantir que o widget seja imutável.
  // O 'key' ajuda a identificar este widget na árvore de widgets do Flutter.
  const MyApp({Key? key}) : super(key: key);

  // O método build é onde o widget define sua estrutura de interface de usuário.
  // O build retorna uma árvore de widgets.
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // MaterialApp é o widget raiz que contém o tema, rotas e outras configurações do aplicativo.
      title: 'Meu App Flutter', 
      home: Scaffold( 
        appBar: AppBar( 
          title: const Text('Exemplo de Widget Imutável'), 
        ),
        body: const Center( // O widget Center centraliza seu filho no meio da tela.
          child: MeuWidgetImutavel(), 
        ),
      ),
    );
  }
}

// A classe MeuWidgetImutavel é um StatelessWidget.
// Isso significa que este widget não terá seu estado alterado depois de ser criado.
class MeuWidgetImutavel extends StatelessWidget {
  // O construtor MeuWidgetImutavel também é imutável (const).
  const MeuWidgetImutavel({Key? key}) : super(key: key);

  // O método build é obrigatório e define o layout do widget.
  // Como é um StatelessWidget, este layout não mudará.
  @override
  Widget build(BuildContext context) {
    return const Text('Eu não terei meu estado alterado'); // Retorna um texto fixo, que não pode ser alterado.
  }
}
