
import 'package:daily_habit/core/consts/design.dart';
import 'package:daily_habit/domain/entities/habit.dart';
import 'package:daily_habit/domain/enums/habit_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HabitCard extends ConsumerWidget {
  final Habit habit;
  final bool isCompleted;
  final VoidCallback onToggle;
  final VoidCallback? onDelete;

  const HabitCard({
    super.key,
    required this.habit,
    required this.isCompleted,
    required this.onToggle,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = _getColorFromHex(habit.accentColor);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onToggle,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _buildIcon(habit.icon, color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit.name,
                        style: AppTextStyles.bodyMedium,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _getTimeText(habit.createdAt),
                        style: AppTextStyles.statLabel,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onToggle,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCompleted ? color : Colors.transparent,
                      border: Border.all(
                        color: isCompleted ? color : AppColors.grey,
                        width: 2,
                      ),
                    ),
                    child: isCompleted
                        ? const Icon(
                      Icons.check,
                      size: 18,
                      color: Colors.white,
                    )
                        : null,
                  ),
                ),
                if (onDelete != null) ...[
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: onDelete,
                    child: const Icon(
                      Icons.more_vert,
                      size: 20,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(HabitIcon icon, Color color) {
    IconData iconData;

    switch (icon) {
      case HabitIcon.yoga:
        iconData = Icons.self_improvement;
        break;
      case HabitIcon.book:
        iconData = Icons.menu_book;
        break;
      case HabitIcon.water:
        iconData = Icons.water_drop;
        break;
      case HabitIcon.meditation:
        iconData = Icons.self_improvement;
        break;
      case HabitIcon.workout:
        iconData = Icons.fitness_center;
        break;
      case HabitIcon.running:
        iconData = Icons.directions_run;
        break;
      case HabitIcon.sleep:
        iconData = Icons.night_shelter;
        break;
      case HabitIcon.healthyFood:
        iconData = Icons.restaurant;
        break;
    }

    return Icon(
      iconData,
      size: 24,
      color: color,
    );
  }

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexColor', radix: 16));
  }

  String _getTimeText(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else {
      return 'Created $difference days ago';
    }
  }
}