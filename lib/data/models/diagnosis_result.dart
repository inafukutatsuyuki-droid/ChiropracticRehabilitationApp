class DiagnosisResult {
  final String patternName;
  final String description;
  final List<String> recommendedCare;
  final Uri? videoUrl;

  const DiagnosisResult({
    required this.patternName,
    required this.description,
    required this.recommendedCare,
    this.videoUrl,
  });
}

class DiagnosisReport {
  final List<DiagnosisResult> patterns;
  final bool showMedicalNotice;

  const DiagnosisReport({
    required this.patterns,
    required this.showMedicalNotice,
  });
}
