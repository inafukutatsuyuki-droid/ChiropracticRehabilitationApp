import 'package:flutter/material.dart';

class OptionSelector extends StatelessWidget {
  final List<String> options;
  final List<String> selected;
  final bool multiSelect;
  final ValueChanged<String> onSelected;

  const OptionSelector({
    super.key,
    required this.options,
    required this.selected,
    required this.multiSelect,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        final isActive = selected.contains(option);
        return FilterChip(
          label: Text(option),
          selected: isActive,
          onSelected: (_) => onSelected(option),
        );
      }).toList(),
    );
  }
}
