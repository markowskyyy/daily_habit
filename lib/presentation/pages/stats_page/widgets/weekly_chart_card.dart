import 'package:daily_habit/core/consts/design.dart';
import 'package:daily_habit/presentation/ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';

class WeeklyChartCard extends StatelessWidget {
  final List<double> weeklyChartData;
  final List<String> weeklyLabels;
  const WeeklyChartCard({super.key, required this.weeklyChartData, required this.weeklyLabels});

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
          Text(
            'Активность',
            style: AppTextStyles.screenTitle,
          ),
          const SizedBox(height: 24),
          ProgressChart(
            data: weeklyChartData,
            labels: weeklyLabels,
          ),
        ],
      ),
    );
  }
}
