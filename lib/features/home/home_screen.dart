import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/repository/pain_diary_repository.dart';
import '../../data/models/pain_diary_entry.dart';

final recentDiaryProvider = FutureProvider<List<PainDiaryEntry>>((ref) {
  final repository = ref.watch(painDiaryRepositoryProvider);
  return repository.fetchRecent();
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentEntries = ref.watch(recentDiaryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('痛み原因セルフ判定'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '3〜5タップでセルフチェック',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '医療行為・診断ではありません。強い痛みや不調がある場合は必ず受診してください。',
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.go('/questionnaire'),
                      child: const Text('セルフチェックをはじめる'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('直近の痛み記録', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Expanded(
              child: recentEntries.when(
                data: (entries) {
                  if (entries.isEmpty) {
                    return const Center(child: Text('まだ記録がありません'));
                  }
                  return ListView.builder(
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      final entry = entries[index];
                      return ListTile(
                        title: Text('${entry.area} | レベル ${entry.painLevel}'),
                        subtitle: Text(entry.patternName),
                        trailing: Text(
                          '${entry.date.month}/${entry.date.day}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('読み込みエラー: $e')),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.go('/diary'),
                    child: const Text('痛み日記を見る'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.go('/settings'),
                    child: const Text('アプリの説明・免責'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: const Text('AdMob バナー（テストIDで差し替え予定）'),
            ),
          ],
        ),
      ),
    );
  }
}
