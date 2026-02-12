import 'package:daily_habit/core/consts/design.dart';
import 'package:flutter/material.dart';

class ConsistencyCard extends StatelessWidget {
  final String text;
  const ConsistencyCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
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
        children: [
          Text(
            text,
            style: AppTextStyles.statNumber,
          ),
          const SizedBox(height: 8),
          Text(
            'НЕДЕЛЬНЫЙ ПРОГРЕСС',
            style: AppTextStyles.statLabel,
          ),
        ],
      ),
    );
  }
}
