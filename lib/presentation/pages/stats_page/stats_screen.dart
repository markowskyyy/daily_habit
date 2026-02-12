

import 'package:daily_habit/core/consts/design.dart';
import 'package:daily_habit/domain/entities/habit.dart';
import 'package:daily_habit/presentation/pages/stats_page/widgets/consistency_card.dart';
import 'package:daily_habit/presentation/pages/stats_page/widgets/most_completed_card.dart';
import 'package:daily_habit/presentation/pages/stats_page/widgets/stats_grid.dart';
import 'package:daily_habit/presentation/pages/stats_page/widgets/streaks_card.dart';
import 'package:daily_habit/presentation/pages/stats_page/widgets/weekly_chart_card.dart';
import 'package:daily_habit/presentation/ui_kit/ui_kit.dart';
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

  // Widget _buildConsistencyCard(StatsViewModel vm) {
  //   return Container(
  //     width: double.infinity,
  //     padding: const EdgeInsets.all(24),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(24),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.02),
  //           blurRadius: 12,
  //           offset: const Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       children: [
  //         Text(
  //           vm.weeklyConsistency,
  //           style: AppTextStyles.statNumber,
  //         ),
  //         const SizedBox(height: 8),
  //         Text(
  //           'НЕДЕЛЬНЫЙ ПРОГРЕСС',
  //           style: AppTextStyles.statLabel,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildWeeklyChartCard(StatsViewModel vm) {
  //   return Container(
  //     padding: const EdgeInsets.all(20),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(24),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.02),
  //           blurRadius: 12,
  //           offset: const Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Активность',
  //           style: AppTextStyles.screenTitle,
  //         ),
  //         const SizedBox(height: 24),
  //         ProgressChart(
  //           data: vm.weeklyChartData,
  //           labels: vm.weeklyLabels,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildStatsGrid(StatsViewModel vm) {
  //   return Container(
  //     padding: const EdgeInsets.all(20),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(24),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.02),
  //           blurRadius: 12,
  //           offset: const Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: Row(
  //       children: [
  //         Expanded(child: _buildStatItem('Лучший день', vm.bestDay)),
  //         Container(height: 40, width: 1, color: AppColors.lightGrey),
  //         Expanded(child: _buildStatItem('Общий счёт', vm.totalCheckins.toString())),
  //         Container(height: 40, width: 1, color: AppColors.lightGrey),
  //         Expanded(child: _buildStatItem('Привычки', vm.habitsCount.toString())),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildStatItem(String label, String value) {
  //   return Column(
  //     children: [
  //       Text(value, style: AppTextStyles.bestDay),
  //       const SizedBox(height: 4),
  //       Text(label, style: AppTextStyles.statLabel, textAlign: TextAlign.center),
  //     ],
  //   );
  // }

  // Widget _buildStreaksCard(StatsViewModel vm) {
  //   return Container(
  //     padding: const EdgeInsets.all(20),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(24),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.02),
  //           blurRadius: 12,
  //           offset: const Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text('Достижения', style: AppTextStyles.screenTitle),
  //         const SizedBox(height: 16),
  //         Row(
  //           children: [
  //             Expanded(
  //               child: _buildStreakItem(
  //                 label: 'Longest',
  //                 value: vm.longestStreakFormatted,
  //                 icon: Icons.local_fire_department,
  //                 color: AppColors.orange,
  //               ),
  //             ),
  //             Expanded(
  //               child: _buildStreakItem(
  //                 label: 'Active',
  //                 value: vm.activeStreaksFormatted,
  //                 icon: Icons.bolt,
  //                 color: AppColors.green,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }


  //
  // Widget _buildMostCompletedCard(StatsViewModel vm) {ew
  //   final mostCompleted = vm.getMostCompletedHabits(limit: 3);
  //
  //   if (mostCompleted.isEmpty) {
  //     return const SizedBox.shrink();
  //   }
  //
  //   return Container(
  //     padding: const EdgeInsets.all(20),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(24),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.02),
  //           blurRadius: 12,
  //           offset: const Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text('Самые активные', style: AppTextStyles.screenTitle),
  //         const SizedBox(height: 16),
  //         ...mostCompleted.entries.map((entry) => _buildHabitRankItem(
  //           habit: entry.key,
  //           count: entry.value,
  //           rank: mostCompleted.keys.toList().indexOf(entry.key) + 1,
  //         )).toList(),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildHabitRankItem({
  //   required Habit habit,
  //   required int count,
  //   required int rank,
  // }) {
  //   final color = _getColorFromHex(habit.accentColor);
  //
  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 12),
  //     child: Row(
  //       children: [
  //         Container(
  //           width: 28,
  //           height: 28,
  //           decoration: BoxDecoration(
  //             color: color.withOpacity(0.1),
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //           child: Center(
  //             child: Text(
  //               '$rank',
  //               style: AppTextStyles.bodyMedium.copyWith(
  //                 color: color,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //         ),
  //         const SizedBox(width: 12),
  //         Expanded(
  //           child: Text(
  //             habit.name,
  //             style: AppTextStyles.bodyMedium.copyWith(
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //         ),
  //         Text(
  //           '$count',
  //           style: AppTextStyles.bestDay.copyWith(color: color),
  //         ),
  //         const SizedBox(width: 4),
  //         Text('x', style: AppTextStyles.statLabel),
  //       ],
  //     ),
  //   );
  // }
  //
  // Color _getColorFromHex(String hexColor) {
  //   hexColor = hexColor.replaceAll('#', '');
  //   return Color(int.parse('FF$hexColor', radix: 16));
  // }

}