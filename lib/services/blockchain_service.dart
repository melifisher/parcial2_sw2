import 'package:http/http.dart' as http;
import 'dart:convert';

class BlockchainService {
  final String baseUrl;

  BlockchainService({this.baseUrl = 'http://localhost:8000'});

  Future<Map<String, dynamic>> registerDocument({
    required String content,
    required String doctorAddress,
    required String ipfsHash,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'content': content,
          'doctor_address': doctorAddress,
          'ipfs_hash': ipfsHash,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to register document: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error registering document: $e');
    }
  }

  Future<Map<String, dynamic>> verifyDocument(String documentHash) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/verify'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'document_hash': documentHash,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to verify document: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error verifying document: $e');
    }
  }
}
