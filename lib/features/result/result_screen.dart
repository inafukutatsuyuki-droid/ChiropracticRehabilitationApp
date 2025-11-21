import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/diagnosis_result.dart';
import '../../data/models/pain_diary_entry.dart';
import '../../data/repository/pain_diary_repository.dart';

class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key, required this.report});

  final DiagnosisReport? report;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(painDiaryRepositoryProvider);
    final patterns = report?.patterns ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('診断結果'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: report == null
            ? const Center(child: Text('結果データがありません'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'セルフチェック結果',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '本アプリは医療行為・診断ではありません。症状が強い場合や不安がある場合は医療機関を受診してください。',
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      itemCount: patterns.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final pattern = patterns[index];
                        return Card(
                          elevation: 0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .outlineVariant,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pattern.patternName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text(pattern.description),
                                const SizedBox(height: 12),
                                Text('おすすめセルフケア',
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                                const SizedBox(height: 4),
                                ...pattern.recommendedCare
                                    .map((care) => Row(
                                          children: [
                                            const Icon(Icons.check,
                                                size: 16, color: Colors.green),
                                            const SizedBox(width: 6),
                                            Expanded(child: Text(care)),
                                          ],
                                        )),
                                if (pattern.videoUrl != null) ...[
                                  const SizedBox(height: 12),
                                  OutlinedButton(
                                    onPressed: () => launchUrl(pattern.videoUrl!),
                                    child: const Text('ストレッチ動画を見る'),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: patterns.isEmpty
                        ? null
                        : () async {
                            final firstPattern = patterns.first;
                            final entry = PainDiaryEntry(
                              date: DateTime.now(),
                              area: firstPattern.patternName.contains('肩')
                                  ? '肩'
                                  : firstPattern.patternName.contains('腰')
                                      ? '腰'
                                      : '膝',
                              painLevel: 5,
                              patternName: firstPattern.patternName,
                            );
                            await repository.saveEntry(entry);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('日記に保存しました')),
                              );
                            }
                          },
                    icon: const Icon(Icons.save_alt),
                    label: const Text('この結果を日記に保存'),
                  ),
                  const SizedBox(height: 8),
                  if (report?.showMedicalNotice == true)
                    Card(
                      color: Theme.of(context).colorScheme.errorContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          'しびれや強い痛みなどの受診推奨サインが含まれています。速やかに医療機関への相談をご検討ください。',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onErrorContainer,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: OutlinedButton(
          onPressed: () => context.go('/home'),
          child: const Text('ホームに戻る'),
        ),
      ),
    );
  }
}
