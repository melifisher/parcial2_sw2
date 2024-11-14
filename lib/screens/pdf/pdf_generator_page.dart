import 'package:flutter/material.dart';
import '../../services/pdf_service.dart';
import '../../widgets/drawer_widget.dart';

class PDFGeneratorPage extends StatefulWidget {
  const PDFGeneratorPage({super.key});

  @override
  _PDFGeneratorPageState createState() => _PDFGeneratorPageState();
}

class _PDFGeneratorPageState extends State<PDFGeneratorPage> {
  final TextEditingController _idController = TextEditingController();
  final PDFService _pdfService = PDFService();

  Future<void> _generatePDF() async {
    try {
      final id = int.parse(_idController.text);
      //await _pdfService.generatePDF(id);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al descargar PDF: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generador de PDF'),
      ),
      drawer: const DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                labelText: 'ID del Test',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generatePDF,
              child: const Text('Generar PDF'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }
}
