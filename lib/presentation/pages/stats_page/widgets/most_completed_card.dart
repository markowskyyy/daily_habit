import 'package:daily_habit/core/consts/design.dart';
import 'package:daily_habit/domain/entities/habit.dart';
import 'package:flutter/material.dart';

class MostCompletedCard extends StatelessWidget {
  final Map<Habit, int> mostCompletedHabits;
  const MostCompletedCard({super.key, required this.mostCompletedHabits});

  @override
  Widget build(BuildContext context) {
    // final mostCompleted = vm.getMostCompletedHabits(limit: 3);

    if (mostCompletedHabits.isEmpty) {
      return const SizedBox.shrink();
    }

    return  Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Самые активные', style: AppTextStyles.screenTitle),
          const SizedBox(height: 16),
          ...mostCompletedHabits.entries.map((entry) => _buildHabitRankItem(
            habit: entry.key,
            count: entry.value,
            rank: mostCompletedHabits.keys.toList().indexOf(entry.key) + 1,
          )).toList(),
        ],
      ),
    );
  }


  Widget _buildHabitRankItem({
    required Habit habit,
    required int count,
    required int rank,
  }) {
    final color = _getColorFromHex(habit.accentColor);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '$rank',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              habit.name,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            '$count',
            style: AppTextStyles.bestDay.copyWith(color: color),
          ),
          const SizedBox(width: 4),
          Text('x', style: AppTextStyles.statLabel),
        ],
      ),
    );
  }

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexColor', radix: 16));
  }
}
