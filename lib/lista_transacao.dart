import 'package:flutter/material.dart';
import 'transacao.dart';
import 'transacao_service.dart';
import 'formulario_transacao.dart';

class ListaTransacao extends StatefulWidget {
  @override
  _ListaTransacaoState createState() => _ListaTransacaoState();
}

class _ListaTransacaoState extends State<ListaTransacao> {
  final _transacaoService = TransacaoService();
  late Future<List<Transacao>> _transacoes;

  @override
  void initState() {
    super.initState();
    _transacoes = _transacaoService.getAll();
  }

  void _atualizarLista() {
    setState(() {
      _transacoes = _transacaoService.getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transações')),
      body: FutureBuilder<List<Transacao>>(
        future: _transacoes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final transacao = snapshot.data![index];
                return ListTile(
                  title: Text(transacao.descricao),
                  subtitle: Text('R\$ ${transacao.valor.toString()}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          final resultado = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  FormularioTransacao(transacao: transacao),
                            ),
                          );
                          if (resultado == true) {
                            _atualizarLista();
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _transacaoService.delete(transacao.id!);
                          _atualizarLista();
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('Nenhuma transação encontrada'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final resultado = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FormularioTransacao(),
            ),
          );
          if (resultado == true) {
            _atualizarLista();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
