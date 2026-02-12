import 'package:daily_habit/core/consts/design.dart';
import 'package:daily_habit/presentation/pages/stats_page/widgets/consistency_card.dart';
import 'package:daily_habit/presentation/pages/stats_page/widgets/most_completed_card.dart';
import 'package:daily_habit/presentation/pages/stats_page/widgets/stats_grid.dart';
import 'package:daily_habit/presentation/pages/stats_page/widgets/streaks_card.dart';
import 'package:daily_habit/presentation/pages/stats_page/widgets/weekly_chart_card.dart';
import 'package:daily_habit/presentation/pages/home_page/view_model/home_viewmodel.dart';
import 'package:daily_habit/presentation/view_models/stats_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsVM = ref.watch(statsViewModelProvider);
    final homeVM = ref.watch(homeViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'Прогресс',
          style: AppTextStyles.screenTitle,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConsistencyCard(text: statsVM.weeklyConsistency),
            const SizedBox(height: 24),
            WeeklyChartCard(
              weeklyChartData: statsVM.weeklyChartData,
              weeklyLabels: statsVM.weeklyLabels,
            ),
            const SizedBox(height: 24),
            StatsGrid(
                bestDay: statsVM.bestDay,
                totalCheckins: statsVM.totalCheckins.toString(),
                habitsCount: statsVM.habitsCount.toString()
            ),
            const SizedBox(height: 24),
            StreaksCard(
              longestStreakFormatted: statsVM.longestStreakFormatted,
              activeStreaksFormatted: statsVM.activeStreaksFormatted,
            ),
            const SizedBox(height: 24),
            MostCompletedCard(
                mostCompletedHabits: statsVM.getMostCompletedHabits(limit: 3)
            ),
          ],
        ),
      ),
    );
  }
}