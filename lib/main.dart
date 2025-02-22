import 'package:flutter/material.dart';
import 'lista_transacao.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicação Bancária',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          ListaTransacao(), // Define a tela inicial como a lista de transações
    );
  }
}
