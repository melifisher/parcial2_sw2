import 'package:flutter/material.dart';
import '../../../models/resultado.dart';
import '../../../services/resultado_service.dart';
import '../../../providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../../../services/pdf_service.dart';
import '../../../models/usuario.dart';

class ResultadoDetailScreen extends StatefulWidget {
  final Resultado resultado;
  const ResultadoDetailScreen({super.key, required this.resultado});

  @override
  State<ResultadoDetailScreen> createState() => _ResultadoDetailScreenState();
}

class _ResultadoDetailScreenState extends State<ResultadoDetailScreen> {
  final ResultadoService _resultadoService = ResultadoService();
  final PDFService _pdfService = PDFService();
  Usuario? user;

  Future<void> _deleteResultado(int id) async {
    await _resultadoService.deleteResultado(id);
    if (mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> _generatePDF() async {
    try {
      await _pdfService.generatePDF(widget.resultado, user!);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al descargar PDF: $e')),
      );
    }
  }

  Future<void> _generateQr() async {
    try {
      final qrCodeData = await _pdfService.getQRCode(widget.resultado, user!);

      await showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Image.memory(qrCodeData)],
            ),
          ),
        ),
      );
    } catch (e) {
      print("Excepción del servicio de PDF: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al generar el qr: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    user = authProvider.user;
    final isAdmin = user?.rol == 'administrator';

    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalle del Resultado'),
          actions: isAdmin
              ? [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/resultado/edit',
                        arguments: widget.resultado,
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Confirmar eliminación'),
                          content: const Text(
                              '¿Está seguro que desea eliminar este resultado?'),
                          actions: [
                            TextButton(
                              child: const Text('Cancelar'),
                              onPressed: () => Navigator.pop(context),
                            ),
                            TextButton(
                              child: const Text('Eliminar'),
                              onPressed: () {
                                Navigator.pop(context);
                                _deleteResultado(widget.resultado.id);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ]
              : null,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: const Text('Resultado',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(widget.resultado.resultado),
                    ),
                    ListTile(
                      title: const Text('Fecha',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(widget.resultado.fecha),
                    ),
                    ListTile(
                      title: const Text('Observaciones',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(widget.resultado.observaciones),
                    ),
                    ListTile(
                      title: const Text('Interpretación',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(widget.resultado.interpretacion),
                    ),
                    ListTile(
                      title: const Text('Detalles',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(widget.resultado.detalles),
                    ),
                    ListTile(
                      title: const Text('ID del Test',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(widget.resultado.testId.toString()),
                    ),
                    const SizedBox(height: 16.0),
                    Center(
                        child: ElevatedButton(
                            child: const Text('Recomendaciones con IA'),
                            onPressed: () {
                              Navigator.pushNamed(context, '/ia',
                                  arguments: widget.resultado);
                            })),
                    const SizedBox(height: 16.0),
                    Center(
                        child: ElevatedButton(
                      onPressed: _generatePDF,
                      child: const Text('Generar PDF'),
                    )),
                    const SizedBox(height: 16.0),
                    Center(
                        child: ElevatedButton(
                      onPressed: _generateQr,
                      child: const Text('Generar Qr de verificación'),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
