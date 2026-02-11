import 'package:daily_habit/core/consts/design.dart';
import 'package:daily_habit/data/providers/stats_provider.dart';
import 'package:flutter/material.dart';

class ProgressChart extends StatelessWidget {
  final List<double> data;
  final List<String> labels;
  final double maxBarHeight;

  const ProgressChart({
    super.key,
    required this.data,
    required this.labels,
    this.maxBarHeight = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(data.length, (index) {
            return _buildBar(
              value: data[index],
              label: labels[index],
            );
          }),
        ),
      ],
    );
  }

  Widget _buildBar({
    required double value,
    required String label,
  }) {
    final barHeight = value * maxBarHeight;

    return Column(
      children: [
        Container(
          width: 24,
          height: barHeight < 4 ? 4 : barHeight,
          decoration: BoxDecoration(
            color: AppColors.green.withOpacity(0.5 + (value * 0.3)),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.statLabel,
        ),
      ],
    );
  }
}

class WeeklyChart extends StatelessWidget {
  final WeeklyStats stats;

  const WeeklyChart({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    final maxValue = stats.dailyCompletions.values.isNotEmpty
        ? stats.dailyCompletions.values.reduce((a, b) => a > b ? a : b)
        : 1;

    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final values = [
      (stats.dailyCompletions[Weekday.monday] ?? 0) / maxValue,
      (stats.dailyCompletions[Weekday.tuesday] ?? 0) / maxValue,
      (stats.dailyCompletions[Weekday.wednesday] ?? 0) / maxValue,
      (stats.dailyCompletions[Weekday.thursday] ?? 0) / maxValue,
      (stats.dailyCompletions[Weekday.friday] ?? 0) / maxValue,
      (stats.dailyCompletions[Weekday.saturday] ?? 0) / maxValue,
      (stats.dailyCompletions[Weekday.sunday] ?? 0) / maxValue,
    ];

    return ProgressChart(
      data: values,
      labels: weekdays,
    );
  }
}