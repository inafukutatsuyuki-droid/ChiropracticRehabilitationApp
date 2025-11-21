class PainDiaryEntry {
  final int? id;
  final DateTime date;
  final String area;
  final int painLevel;
  final String patternName;
  final String memo;

  const PainDiaryEntry({
    this.id,
    required this.date,
    required this.area,
    required this.painLevel,
    required this.patternName,
    this.memo = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'area': area,
      'painLevel': painLevel,
      'patternName': patternName,
      'memo': memo,
    };
  }

  factory PainDiaryEntry.fromMap(Map<String, dynamic> map) {
    return PainDiaryEntry(
      id: map['id'] as int?,
      date: DateTime.parse(map['date'] as String),
      area: map['area'] as String,
      painLevel: map['painLevel'] as int,
      patternName: map['patternName'] as String,
      memo: map['memo'] as String? ?? '',
    );
  }
}
