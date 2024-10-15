import 'api_service.dart';
import 'transacao.dart';

class TransacaoService extends ApiService<Transacao> {
  @override
  String get apiUrl => 'http://localhost:3000/transacoes';

  @override
  Transacao fromJson(Map<String, dynamic> json) {
    return Transacao.fromJson(json);
  }
}
