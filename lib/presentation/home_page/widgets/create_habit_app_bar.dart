import 'package:daily_habit/core/consts/design.dart';
import 'package:flutter/material.dart';

class CreateHabitAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CreateHabitAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: AppColors.darkText,
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'New Habit',
        style: AppTextStyles.screenTitle,
      ),
    );
  }
}