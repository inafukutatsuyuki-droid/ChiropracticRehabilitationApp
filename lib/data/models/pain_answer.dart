class PainAnswer {
  final String questionId;
  final List<String> selected;

  const PainAnswer({
    required this.questionId,
    required this.selected,
  });
}

class QuestionnaireState {
  final int currentIndex;
  final List<PainAnswer> answers;

  const QuestionnaireState({
    required this.currentIndex,
    required this.answers,
  });

  QuestionnaireState copyWith({
    int? currentIndex,
    List<PainAnswer>? answers,
  }) {
    return QuestionnaireState(
      currentIndex: currentIndex ?? this.currentIndex,
      answers: answers ?? this.answers,
    );
  }
}
