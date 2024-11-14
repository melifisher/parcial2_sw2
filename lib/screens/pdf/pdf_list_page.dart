import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../services/pdf_service.dart';
import '../../widgets/drawer_widget.dart';

class PDFListPage extends StatelessWidget {
  final PDFService _pdfService = PDFService();

  PDFListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userId = authProvider.user?.id;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis PDFs'),
      ),
      drawer: const DrawerWidget(),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _pdfService.getPDFs(userId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final pdfs = snapshot.data!;

          return ListView.builder(
            itemCount: pdfs.length,
            itemBuilder: (context, index) {
              final pdf = pdfs[index];
              return ListTile(
                leading: const Icon(Icons.picture_as_pdf),
                title: Text(pdf['nombre'] ?? 'PDF sin nombre'),
                subtitle: Text('Fecha: ${pdf['fecha_resultado']}'),
                trailing: IconButton(
                  icon: const Icon(Icons.download),
                  onPressed: () async {
                    //await _pdfService.generatePDF(pdf['id']);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
