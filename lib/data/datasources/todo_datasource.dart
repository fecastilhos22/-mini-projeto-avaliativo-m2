import 'dart:convert';
import 'package:http/http.dart' as http;

class TodoDatasource {
  final String _baseUrl = 'https://dummyjson.com';

  // Retorna a lista bruta de Maps (JSON) vinda da API
  Future<List<dynamic>> getTodos() async {
    final url = Uri.parse('$_baseUrl/todos');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data['todos'] as List<dynamic>;
    } else {
      throw Exception('Erro ao buscar as tarefas');
    }
  }
}
