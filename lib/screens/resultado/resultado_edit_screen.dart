import 'package:flutter/material.dart';
import '../../../models/resultado.dart';
import '../../../services/resultado_service.dart';

class ResultadoEditScreen extends StatefulWidget {
  const ResultadoEditScreen({super.key});

  @override
  State<ResultadoEditScreen> createState() => _ResultadoEditScreenState();
}

class _ResultadoEditScreenState extends State<ResultadoEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final ResultadoService _resultadoService = ResultadoService();

  late TextEditingController _resultadoController;
  late TextEditingController _fechaController;
  late TextEditingController _observacionesController;
  late TextEditingController _interpretacionController;
  late TextEditingController _detallesController;
  late TextEditingController _testIdController;

  @override
  void initState() {
    super.initState();
    _resultadoController = TextEditingController();
    _fechaController = TextEditingController();
    _observacionesController = TextEditingController();
    _interpretacionController = TextEditingController();
    _detallesController = TextEditingController();
    _testIdController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final resultado = ModalRoute.of(context)!.settings.arguments as Resultado;
    _resultadoController.text = resultado.resultado;
    _fechaController.text = resultado.fecha;
    _observacionesController.text = resultado.observaciones;
    _interpretacionController.text = resultado.interpretacion;
    _detallesController.text = resultado.detalles;
    _testIdController.text = resultado.testId.toString();
  }

  @override
  void dispose() {
    _resultadoController.dispose();
    _fechaController.dispose();
    _observacionesController.dispose();
    _interpretacionController.dispose();
    _detallesController.dispose();
    _testIdController.dispose();
    super.dispose();
  }

  Future<void> _saveResultado() async {
    if (_formKey.currentState!.validate()) {
      final resultado = ModalRoute.of(context)!.settings.arguments as Resultado;

      final updatedResultado = Resultado(
        id: resultado.id,
        resultado: _resultadoController.text,
        fecha: _fechaController.text,
        observaciones: _observacionesController.text,
        interpretacion: _interpretacionController.text,
        detalles: _detallesController.text,
        testId: int.parse(_testIdController.text),
      );

      await _resultadoService.updateResultado(updatedResultado);
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Resultado'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _resultadoController,
                decoration: const InputDecoration(labelText: 'Resultado'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el resultado';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _fechaController,
                decoration: const InputDecoration(labelText: 'Fecha'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la fecha';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _observacionesController,
                decoration: const InputDecoration(labelText: 'Observaciones'),
                maxLines: 3,
              ),
              TextFormField(
                controller: _interpretacionController,
                decoration: const InputDecoration(labelText: 'Interpretación'),
                maxLines: 3,
              ),
              TextFormField(
                controller: _detallesController,
                decoration: const InputDecoration(labelText: 'Detalles'),
                maxLines: 3,
              ),
              TextFormField(
                controller: _testIdController,
                decoration: const InputDecoration(labelText: 'ID del Test'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el ID del test';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingrese un número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveResultado,
                child: const Text('Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
