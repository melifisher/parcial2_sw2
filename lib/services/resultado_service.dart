import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/resultado.dart';
import '../config/environment/environment.dart';

class ResultadoService {
  ResultadoService();

  Future<List<Resultado>> getResultados(int? usuarioId) async {
    try {
      final response = usuarioId == null
          ? await http.get(Uri.parse('${Environment.apiUrl}/api/resultados'))
          : await http.get(Uri.parse(
              '${Environment.apiUrl}/api/resultados/paciente/$usuarioId'));
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> productsJson = json.decode(response.body);
        return productsJson.map((json) => Resultado.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load resultados');
      }
    } catch (e) {
      print('Error loading resultados: $e');
      throw Exception(e);
    }
  }

  Future<Resultado> getResultado(int id) async {
    try {
      final response =
          await http.get(Uri.parse('${Environment.apiUrl}/api/resultados/$id'));
      if (response.statusCode == 200) {
        final dynamic categoryJson = json.decode(response.body);
        return Resultado.fromJson(categoryJson);
      } else {
        throw Exception('Failed to load resultado');
      }
    } catch (e) {
      print('Error loading resultado: $e');
      throw Exception(e);
    }
  }

  Future<Resultado> createResultado(Resultado resultado) async {
    final response = await http.post(
      Uri.parse('${Environment.apiUrl}/api/resultados'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(resultado.toJson()),
    );
    if (response.statusCode == 201) {
      return Resultado.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create resultado');
    }
  }

  Future<Resultado> updateResultado(Resultado resultado) async {
    final response = await http.put(
      Uri.parse('${Environment.apiUrl}/api/resultados/${resultado.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(resultado.toJson()),
    );
    if (response.statusCode == 200) {
      return Resultado.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update resultado');
    }
  }

  Future<void> deleteResultado(int id) async {
    final response = await http
        .delete(Uri.parse('${Environment.apiUrl}/api/resultados/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete resultado');
    }
  }
}
