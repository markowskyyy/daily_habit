import 'package:daily_habit/core/consts/design.dart';
import 'package:daily_habit/domain/enums/habit_icon.dart';
import 'package:daily_habit/presentation/ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';


class IconSelectorSection extends StatelessWidget {
  final List<HabitIcon> icons;
  final HabitIcon selectedIcon;
  final String selectedColor;
  final ValueChanged<HabitIcon> onIconSelected;

  const IconSelectorSection({
    super.key,
    required this.icons,
    required this.selectedIcon,
    required this.selectedColor,
    required this.onIconSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ICON', style: AppTextStyles.formLabel),
        const SizedBox(height: 16),
        IconGrid(
          icons: icons,
          selectedIcon: selectedIcon,
          selectedColor: selectedColor,
          onIconSelected: onIconSelected,
        ),
      ],
    );
  }
}