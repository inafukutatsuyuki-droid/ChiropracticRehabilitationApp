import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../logic/diagnosis_rules.dart';
import '../../common/widgets/option_selector.dart';
import '../data/questions.dart';
import '../providers/questionnaire_notifier.dart';

class QuestionnaireScreen extends ConsumerWidget {
  const QuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(questionnaireProvider);
    final notifier = ref.read(questionnaireProvider.notifier);
    final question = notifier.currentQuestion;
    final answers = state.answers
        .where((element) => element.questionId == question.id)
        .map((e) => e.selected)
        .firstOrNull ??
        [];

    final progress = (state.currentIndex + 1) / questionnaire.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('セルフチェック'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(value: progress),
            const SizedBox(height: 12),
            Text('質問 ${state.currentIndex + 1} / ${questionnaire.length}',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Expanded(
              child: Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      OptionSelector(
                        options: question.options,
                        selected: answers,
                        multiSelect: question.multiSelect,
                        onSelected: notifier.selectOption,
                      ),
                      const Spacer(),
                      const Text(
                        '※本アプリは医療行為・診断ではありません。強い痛みや不調が続く場合は専門医へご相談ください。',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: state.currentIndex > 0 ? notifier.back : null,
                    child: const Text('戻る'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (state.currentIndex < questionnaire.length - 1) {
                        notifier.next();
                      } else {
                        final report = diagnose(state.answers);
                        context.go('/result', extra: report);
                        notifier.reset();
                      }
                    },
                    child: Text(
                      state.currentIndex == questionnaire.length - 1
                          ? '結果を見る'
                          : '次へ',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
