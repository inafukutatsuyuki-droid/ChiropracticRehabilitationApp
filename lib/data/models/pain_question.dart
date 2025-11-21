class PainQuestion {
  final String id;
  final String title;
  final List<String> options;
  final bool multiSelect;

  const PainQuestion({
    required this.id,
    required this.title,
    required this.options,
    this.multiSelect = false,
  });
}
