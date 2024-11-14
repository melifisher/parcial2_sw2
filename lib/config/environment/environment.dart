import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

class Environment {
  static initEnvironment() async {
    await dotenv.load(fileName: '.env');
  }

  String ipPc = "192.168.0.10";
  static String apiUrl =
      dotenv.env['API_URL'] ?? 'No está configurado el API_URL';
  static String apiPdf =
      dotenv.env['API_PDF'] ?? 'No está configurado el API_PDF';
  static String apiIA = dotenv.env['API_IA'] ?? 'No está configurado el API_IA';
  static String apiBlockchain =
      dotenv.env['API_BLOCKCHAIN'] ?? 'No está configurado el API_BLOCKCHAIN';
}
