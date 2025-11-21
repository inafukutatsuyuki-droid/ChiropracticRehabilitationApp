import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../db/app_database.dart';
import '../models/pain_diary_entry.dart';

final painDiaryRepositoryProvider = Provider<PainDiaryRepository>((ref) {
  return PainDiaryRepository(database: AppDatabase());
});

class PainDiaryRepository {
  final AppDatabase database;

  const PainDiaryRepository({required this.database});

  Future<int> saveEntry(PainDiaryEntry entry) async {
    final db = await database.database;
    return db.insert('pain_diary', entry.toMap());
  }

  Future<List<PainDiaryEntry>> fetchRecent({int limit = 3}) async {
    final db = await database.database;
    final rows = await db.query(
      'pain_diary',
      orderBy: 'date DESC',
      limit: limit,
    );
    return rows.map(PainDiaryEntry.fromMap).toList();
  }

  Future<List<PainDiaryEntry>> fetchAll() async {
    final db = await database.database;
    final rows = await db.query(
      'pain_diary',
      orderBy: 'date DESC',
    );
    return rows.map(PainDiaryEntry.fromMap).toList();
  }
}
