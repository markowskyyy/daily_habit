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
