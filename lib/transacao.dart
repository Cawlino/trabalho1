class Transacao {
  int? id;
  String descricao;
  double valor;

  Transacao({this.id, required this.descricao, required this.valor});

  factory Transacao.fromJson(Map<String, dynamic> json) {
    return Transacao(
      id: json['id'],
      descricao: json['descricao'],
      valor: json['valor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'valor': valor,
    };
  }
}
