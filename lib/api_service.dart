import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class ApiService<T> {
  String get apiUrl;

  T fromJson(Map<String, dynamic> json);

  Future<List<T>> getAll() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      Iterable data = jsonDecode(response.body);
      return data.map((json) => fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar dados');
    }
  }

  Future<T> create(T item) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(item),
    );
    if (response.statusCode == 201) {
      return fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao criar item');
    }
  }

  Future<T> update(int id, T item) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(item),
    );
    if (response.statusCode == 200) {
      return fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao atualizar item');
    }
  }

  Future<void> delete(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar item');
    }
  }
}
