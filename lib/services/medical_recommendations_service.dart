import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/environment/environment.dart';
import '../models/resultado.dart';

class MedicalRecommendationsService {
  final String baseUrl = '${Environment.apiIA}/medical-recommendations';

  Future<Map<String, dynamic>> getMedicalRecommendations(
      Resultado resultado) async {
    try {
      final requestBody = resultado.toJson();
      print('Request URL: $baseUrl');
      print('Request Body: ${jsonEncode(requestBody)}');

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to get recommendations: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e, stackTrace) {
      print("Exception in medical recommendation: $e");
      print("Stack trace: $stackTrace");
      throw Exception('Error connecting to the service: $e');
    }
  }
}
