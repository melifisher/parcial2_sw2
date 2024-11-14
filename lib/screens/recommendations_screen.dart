import 'package:flutter/material.dart';
import '../../models/resultado.dart';
import '../services/medical_recommendations_service.dart';
import '../models/recommendations_response.dart';
import '../../widgets/drawer_widget.dart';

class RecommendationsScreen extends StatefulWidget {
  final Resultado resultado;
  const RecommendationsScreen({super.key, required this.resultado});

  @override
  _RecommendationsScreenState createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  final _service = MedicalRecommendationsService();
  RecommendationsResponse? _recommendations;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchRecommendations();
  }

  Future<void> _fetchRecommendations() async {
    setState(() => _isLoading = true);
    try {
      final examData = {
        'results': [
          {'test': 'glucose', 'value': 100},
          {'test': 'cholesterol', 'value': 180},
        ]
      };

      final response =
          await _service.getMedicalRecommendations(widget.resultado);
      setState(() {
        _recommendations = RecommendationsResponse.fromJson(response);
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Recommendations'),
      ),
      drawer: const DrawerWidget(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _recommendations == null
              ? Center(
                  child: ElevatedButton(
                    onPressed: _fetchRecommendations,
                    child: const Text('Get Recommendations'),
                  ),
                )
              : ListView.builder(
                  itemCount: _recommendations!.recommendations.length,
                  itemBuilder: (context, index) {
                    final rec = _recommendations!.recommendations[index];
                    return ListTile(
                      title: Text(rec.recommendation),
                      subtitle: Text(rec.description),
                    );
                  },
                ),
    );
  }
}
