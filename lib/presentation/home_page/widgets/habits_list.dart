import 'package:daily_habit/domain/entities/habit.dart';
import 'package:daily_habit/presentation/ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';

class HabitsList extends StatelessWidget {
  final List<Habit> habits;
  final bool Function(String habitId) isCompleted;
  final void Function(String habitId) onToggle;
  final void Function(Habit habit) onDelete;

  const HabitsList({
    super.key,
    required this.habits,
    required this.isCompleted,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: habits.length,
      itemBuilder: (context, index) {
        final habit = habits[index];
        final completed = isCompleted(habit.id);

        return HabitCard(
          habit: habit,
          isCompleted: completed,
          onToggle: () => onToggle(habit.id),
          onDelete: () => onDelete(habit),
        );
      },
    );
  }
}