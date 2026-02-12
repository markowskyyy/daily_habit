import 'package:daily_habit/core/consts/design.dart';
import 'package:daily_habit/domain/enums/habit_icon.dart';
import 'package:daily_habit/presentation/ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';


class IconGrid extends StatelessWidget {
  final List<HabitIcon> icons;
  final HabitIcon selectedIcon;
  final String selectedColor;
  final ValueChanged<HabitIcon> onIconSelected;

  const IconGrid({
    super.key,
    required this.icons,
    required this.selectedIcon,
    required this.selectedColor,
    required this.onIconSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: icons.map((icon) {
        return IconItem(
          icon: icon,
          isSelected: icon == selectedIcon,
          selectedColor: selectedColor,
          onTap: () => onIconSelected(icon),
        );
      }).toList(),
    );
  }
}

class IconItem extends StatelessWidget {
  final HabitIcon icon;
  final bool isSelected;
  final String selectedColor;
  final VoidCallback onTap;

  const IconItem({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.selectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = ColorUtils.fromHex(selectedColor);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: isSelected
              ? color.withOpacity(0.1)
              : AppColors.lightGrey,
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(color: color, width: 2)
              : null,
        ),
        child: Icon(
          IconUtils.fromHabitIcon(icon),
          color: isSelected ? color : AppColors.grey,
          size: 28,
        ),
      ),
    );
  }
}