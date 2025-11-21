import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/pain_diary_entry.dart';
import '../../data/repository/pain_diary_repository.dart';

final diaryListProvider = FutureProvider<List<PainDiaryEntry>>((ref) {
  return ref.watch(painDiaryRepositoryProvider).fetchAll();
});

class DiaryScreen extends ConsumerWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diaryList = ref.watch(diaryListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('痛み日記'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: diaryList.when(
          data: (entries) {
            if (entries.isEmpty) {
              return const Center(child: Text('まだ記録がありません'));
            }
            return ListView.separated(
              itemCount: entries.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final entry = entries[index];
                return ListTile(
                  title: Text('${entry.area} | レベル ${entry.painLevel}'),
                  subtitle: Text(entry.patternName),
                  trailing: Text(
                    '${entry.date.year}/${entry.date.month}/${entry.date.day}',
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      showDragHandle: true,
                      builder: (_) => _DiaryDetail(entry: entry),
                    );
                  },
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('読み込みエラー: $e')),
        ),
      ),
    );
  }
}

class _DiaryDetail extends StatelessWidget {
  const _DiaryDetail({required this.entry});

  final PainDiaryEntry entry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(entry.patternName,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('部位: ${entry.area}'),
          Text('痛みレベル: ${entry.painLevel}'),
          const SizedBox(height: 12),
          Text('メモ: ${entry.memo.isEmpty ? 'なし' : entry.memo}'),
          const SizedBox(height: 12),
          Text(
            '注意: 本アプリは医療行為ではありません。症状が強い場合や不安がある場合は専門医へご相談ください。',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
