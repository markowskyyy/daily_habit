import 'package:daily_habit/core/consts/design.dart';
import 'package:flutter/material.dart';

class StatsGrid extends StatelessWidget {
  final String bestDay;
  final String totalCheckins;
  final String habitsCount;
  const StatsGrid({super.key, required this.bestDay, required this.totalCheckins, required this.habitsCount});

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
      child: Row(
        children: [
          Expanded(child: _buildStatItem('Лучший день', bestDay)),
          Container(height: 40, width: 1, color: AppColors.lightGrey),
          Expanded(child: _buildStatItem('Общий счёт', totalCheckins)),
          Container(height: 40, width: 1, color: AppColors.lightGrey),
          Expanded(child: _buildStatItem('Привычки', habitsCount)),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.bestDay),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.statLabel, textAlign: TextAlign.center),
      ],
    );
  }
}
