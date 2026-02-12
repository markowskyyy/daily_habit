import 'package:daily_habit/core/consts/design.dart';
import 'package:flutter/material.dart';

class StreaksCard extends StatelessWidget {
  final String longestStreakFormatted;
  final String activeStreaksFormatted;
  const StreaksCard({super.key, required this.longestStreakFormatted, required this.activeStreaksFormatted});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text('Достижения', style: AppTextStyles.screenTitle),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStreakItem(
                  label: 'Длительность',
                  value: longestStreakFormatted,
                  icon: Icons.local_fire_department,
                  color: AppColors.orange,
                ),
              ),
              Expanded(
                child: _buildStreakItem(
                  label: 'Активность',
                  value: activeStreaksFormatted,
                  icon: Icons.bolt,
                  color: AppColors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStreakItem({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: AppTextStyles.bestDay),
            Text(label, style: AppTextStyles.statLabel),
          ],
        ),
      ],
    );
  }
}
