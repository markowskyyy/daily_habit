import 'package:daily_habit/core/consts/design.dart';
import 'package:daily_habit/presentation/ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';

class ColorItem extends StatelessWidget {
  final String hexColor;
  final bool isSelected;
  final VoidCallback onTap;

  const ColorItem({
    super.key,
    required this.hexColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = ColorUtils.fromHex(hexColor);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(
            color: AppColors.darkText,
            width: 3,
          )
              : null,
        ),
        child: isSelected
            ? const Center(
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: 28,
          ),
        )
            : null,
      ),
    );
  }
}