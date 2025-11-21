import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/pain_answer.dart';
import '../../../data/models/pain_question.dart';
import '../data/questions.dart';

final questionnaireProvider =
    StateNotifierProvider<QuestionnaireNotifier, QuestionnaireState>((ref) {
  return QuestionnaireNotifier(questions: questionnaire);
});

class QuestionnaireNotifier extends StateNotifier<QuestionnaireState> {
  QuestionnaireNotifier({required this.questions})
      : super(const QuestionnaireState(currentIndex: 0, answers: []));

  final List<PainQuestion> questions;

  PainQuestion get currentQuestion => questions[state.currentIndex];

  void selectOption(String option) {
    final question = currentQuestion;
    final existing = _findAnswer(question.id);
    List<String> updatedSelections;

    if (question.multiSelect) {
      if (existing != null && existing.selected.contains(option)) {
        updatedSelections = List<String>.from(existing.selected)..remove(option);
      } else {
        updatedSelections = List<String>.from(existing?.selected ?? [])
          ..add(option);
      }
    } else {
      updatedSelections = [option];
    }

    _updateAnswer(question.id, updatedSelections);
  }

  void next() {
    if (state.currentIndex < questions.length - 1) {
      state = state.copyWith(currentIndex: state.currentIndex + 1);
    }
  }

  void back() {
    if (state.currentIndex > 0) {
      state = state.copyWith(currentIndex: state.currentIndex - 1);
    }
  }

  void reset() {
    state = const QuestionnaireState(currentIndex: 0, answers: []);
  }

  PainAnswer? _findAnswer(String id) {
    return state.answers.where((element) => element.questionId == id).firstOrNull;
  }

  void _updateAnswer(String questionId, List<String> selections) {
    final filtered =
        state.answers.where((element) => element.questionId != questionId);
    final newAnswers = [
      ...filtered,
      PainAnswer(questionId: questionId, selected: selections),
    ];
    state = state.copyWith(answers: newAnswers);
  }
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
