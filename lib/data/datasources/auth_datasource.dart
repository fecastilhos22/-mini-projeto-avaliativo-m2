import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthDatasource {
  final String _baseUrl = 'https://dummyjson.com';

  // Retorna o Map (JSON decodificado) em caso de sucesso,
  // ou lança uma Exception em caso de erro — quem chama decide o que fazer com isso
  Future<Map<String, dynamic>> login(String username, String password) async {
    final url = Uri.parse('$_baseUrl/auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Usuário ou senha inválidos');
    }
  }
}