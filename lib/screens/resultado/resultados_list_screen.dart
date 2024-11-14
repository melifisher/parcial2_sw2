import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/resultado_service.dart';
import '../../../models/resultado.dart';
import '../../../models/usuario.dart';
import '../../../providers/auth_provider.dart';
import '../../../widgets/drawer_widget.dart';
import '../../../services/pdf_service.dart';

class ResultadoListScreen extends StatefulWidget {
  const ResultadoListScreen({super.key});
  @override
  _ResultadoListScreenState createState() => _ResultadoListScreenState();
}

class _ResultadoListScreenState extends State<ResultadoListScreen> {
  final ResultadoService _controller = ResultadoService();
  final PDFService _pdfService = PDFService();
  List<Resultado> _resultados = [];
  Usuario? user;

  @override
  void initState() {
    super.initState();
    _loadResultados();
  }

  Future<void> _loadResultados() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    user = authProvider.user;

    if (user != null) {
      print("Antes de entrar al result_service");
      List<Resultado> resultados = await _controller.getResultados(user!.id);
      /* if (user!.rol == 'administrator') {
        resultados = await _controller.getResultados(null);
      } else {
        resultados = await _controller.getResultados(user!.id);
      } */
      //resultados = await _controller.getResultados(user!.id);
      setState(() {
        _resultados = resultados;
      });
    }
  }

  Future<void> _generatePDF(Resultado resultado) async {
    try {
      await _pdfService.generatePDF(resultado, user!);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al descargar PDF: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Resultados')),
      drawer: const DrawerWidget(),
      body: ListView.builder(
        itemCount: _resultados.length,
        itemBuilder: (context, index) {
          final resultado = _resultados[index];
          return ListTile(
            title: Text(resultado.resultado),
            subtitle: Text(resultado.fecha),
            trailing: FloatingActionButton(
                child: const Text("IA"),
                onPressed: () {
                  Navigator.pushNamed(context, '/ia', arguments: resultado);
                }),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/resultado',
                arguments: resultado,
              ).then((_) => _loadResultados());
            },
          );
        },
      ),
      floatingActionButton: user?.rol == 'administrator'
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/rental',
                ).then((_) => _loadResultados());
              },
            )
          : null,
    );
  }
}
