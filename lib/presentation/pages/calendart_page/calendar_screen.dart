import 'package:daily_habit/core/consts/design.dart';
import 'package:daily_habit/core/router/app_router.dart';
import 'package:daily_habit/presentation/pages/home_page/view_model/home_viewmodel.dart';
import 'package:daily_habit/presentation/ui_kit/frequent/calendar_grid.dart';
import 'package:daily_habit/presentation/view_models/calendar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(calendarViewModelProvider).setCurrentMonth(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(calendarViewModelProvider);
    final monthlyCompletions = vm.getMonthlyCompletions();
    final homeState = ref.watch(homeViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'History',
          style: AppTextStyles.screenTitle,
        ),
      ),
      body: Column(
        children: [
          _buildMonthNavigation(vm),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CalendarGrid(
                    currentMonth: vm.currentMonth,
                    completionCounts: monthlyCompletions,
                    selectedDate: vm.selectedDate,
                    onDaySelected: (date) {
                      final now = DateTime.now();
                      final today = DateTime(now.year, now.month, now.day);
                      final selectedDay = DateTime(date.year, date.month, date.day);

                      if (!selectedDay.isAfter(today)) {
                        vm.selectDate(date);
                        appRouter.goToHome(context);
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  _buildLegend(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthNavigation(CalendarViewModel vm) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            color: AppColors.darkText,
            onPressed: () {
              setState(() => vm.previousMonth());
            },
          ),
          Text(
            vm.formattedMonthYear,
            style: AppTextStyles.screenTitle,
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            color: AppColors.darkText,
            onPressed: () {
              setState(() => vm.nextMonth());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLegendItem(AppColors.green, 'Выполнено'),
          const SizedBox(width: 24),
          _buildLegendItem(AppColors.grey, 'Не выполнено'),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: AppTextStyles.bodyMedium,
        ),
      ],
    );
  }
}