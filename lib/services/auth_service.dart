import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/environment/environment.dart';
import '../models/usuario.dart';

class AuthService {
  final String baseUrl = '${Environment.apiUrl}/api';

  Future<Usuario> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );
      print(response.body);
      if (response.statusCode == 200) {
        print("entro al code 200");
        return Usuario.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }

  Future<Usuario> register(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user': username,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        print(response.body);
        return Usuario.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to register: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during registration: $e');
    }
  }

  Future<Usuario> getUserById(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/$userId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return Usuario.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to get user by ID: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during getUserById: $e');
    }
  }
}
