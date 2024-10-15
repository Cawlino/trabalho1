import 'package:flutter/material.dart';
import 'transacao.dart';
import 'transacao_service.dart';

class FormularioTransacao extends StatefulWidget {
  final Transacao? transacao;

  FormularioTransacao({this.transacao});

  @override
  _FormularioTransacaoState createState() => _FormularioTransacaoState();
}

class _FormularioTransacaoState extends State<FormularioTransacao> {
  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();
  final _transacaoService = TransacaoService();

  @override
  void initState() {
    super.initState();
    if (widget.transacao != null) {
      _descricaoController.text = widget.transacao!.descricao;
      _valorController.text = widget.transacao!.valor.toString();
    }
  }

  void _salvarTransacao() {
    final descricao = _descricaoController.text;
    final valor = double.tryParse(_valorController.text) ?? 0.0;

    if (widget.transacao == null) {
      _transacaoService.create(Transacao(descricao: descricao, valor: valor));
    } else {
      _transacaoService.update(
          widget.transacao!.id!, Transacao(descricao: descricao, valor: valor));
    }

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nova Transação')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            TextField(
              controller: _valorController,
              decoration: InputDecoration(labelText: 'Valor'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: _salvarTransacao,
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
