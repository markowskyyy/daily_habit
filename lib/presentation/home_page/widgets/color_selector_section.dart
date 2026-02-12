import 'package:daily_habit/core/consts/design.dart';
import 'package:daily_habit/presentation/ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';

class ColorSelectorSection extends StatelessWidget {
  final List<String> colors;
  final String selectedColor;
  final ValueChanged<String> onColorSelected;

  const ColorSelectorSection({
    super.key,
    required this.colors,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Выберите цвет', style: AppTextStyles.formLabel),
        const SizedBox(height: 16),
        ColorGrid(
          colors: colors,
          selectedColor: selectedColor,
          onColorSelected: onColorSelected,
        ),
      ],
    );
  }
}