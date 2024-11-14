import 'medical_recommendation.dart';

class RecommendationsResponse {
  final List<MedicalRecommendation> recommendations;
  final Map<String, dynamic> summary;

  RecommendationsResponse({
    required this.recommendations,
    required this.summary,
  });

  factory RecommendationsResponse.fromJson(Map<String, dynamic> json) {
    return RecommendationsResponse(
      recommendations: (json['recommendations'] as List)
          .map((rec) => MedicalRecommendation.fromJson(rec))
          .toList(),
      summary: json['summary'],
    );
  }
}
