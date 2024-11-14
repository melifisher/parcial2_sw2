class MedicalRecommendation {
  final String recommendation;
  final String description;

  MedicalRecommendation({
    required this.recommendation,
    required this.description,
  });

  factory MedicalRecommendation.fromJson(Map<String, dynamic> json) {
    return MedicalRecommendation(
      recommendation: json['recomendation'],
      description: json['description'],
    );
  }
}
