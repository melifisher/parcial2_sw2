import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../config/environment/environment.dart';
import 'package:flutter/foundation.dart';
import '../../../models/resultado.dart';
import '../../../models/usuario.dart';
import 'dart:html' as html;

class PDFService {
  final String baseUrl = Environment.apiPdf;

  Future<void> generatePDF(Resultado resultado, Usuario usuario) async {
    try {
      final body = jsonEncode({
        ...resultado.toJson(),
        'nombre': usuario.nombre,
        'apellidos': usuario.apellidos
      });
      print("El cuerpo q entrara a la peticion: $body");
      final response = await http.post(
        Uri.parse('$baseUrl/generate-pdf'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body,
      );
      print(response);
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        if (kIsWeb) {
          print("Toy web");
          // Crea un blob y una URL para descargar el archivo
          final blob = html.Blob([bytes], 'application/pdf');
          final url = html.Url.createObjectUrlFromBlob(blob);

          // Abre el PDF en una nueva pestaña
          html.window.open(url, "_blank");
          // Limpia el recurso URL después de la descarga
          html.Url.revokeObjectUrl(url);
        } else {
          final directory = await getApplicationDocumentsDirectory();
          final filePath = "${directory.path}/reporte.pdf";
          final file = File(filePath);

          await file.writeAsBytes(bytes);
          print("PDF descargado en $filePath");
        }

        //return jsonDecode(response.body);
      } else {
        throw Exception('Error generating PDF: ${response.statusCode}');
      }
    } catch (e) {
      print("Excepcion del servicio de pdf: $e");
      throw Exception('Network error: $e');
    }
  }

  Future<Uint8List> getQRCode(Resultado resultado, Usuario usuario) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/qr-code'),
          body: jsonEncode({
            ...resultado.toJson(),
            'nombre': usuario.nombre,
            'apellidos': usuario.apellidos
          }),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw Exception('Error getting QR code: ${response.statusCode}');
      }
    } catch (e) {
      print("Excepción del servicio de PDF: $e");
      throw Exception('Network error: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getPDFs(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/pdfs/user/$userId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> pdfsJson = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(pdfsJson);
      } else {
        throw Exception('Error fetching PDFs: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
