import 'package:daily_habit/core/consts/design.dart';
import 'package:daily_habit/domain/entities/habit.dart';
import 'package:flutter/material.dart';


class DeleteHabitDialog extends StatelessWidget {
  final Habit habit;
  final VoidCallback onDelete;

  const DeleteHabitDialog({
    super.key,
    required this.habit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Habit', style: AppTextStyles.screenTitle),
      content: Text(
        'Are you sure you want to delete "${habit.name}"?',
        style: AppTextStyles.bodyMedium,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: AppTextStyles.buttonLight),
        ),
        TextButton(
          onPressed: () {
            onDelete();
            Navigator.pop(context);
          },
          child: Text(
            'Delete',
            style: AppTextStyles.buttonLight.copyWith(color: AppColors.red),
          ),
        ),
      ],
    );
  }
}