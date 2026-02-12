import 'package:daily_habit/presentation/ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';

class ColorGrid extends StatelessWidget {
  final List<String> colors;
  final String selectedColor;
  final ValueChanged<String> onColorSelected;

  const ColorGrid({
    super.key,
    required this.colors,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: colors.map((hexColor) {
        return ColorItem(
          hexColor: hexColor,
          isSelected: hexColor == selectedColor,
          onTap: () => onColorSelected(hexColor),
        );
      }).toList(),
    );
  }
}