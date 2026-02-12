// lib/presentation/home_page/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/consts/design.dart';
import '../../../domain/entities/habit.dart';
import '../../ui_kit/ui_kit.dart';
import '../view_model/home_viewmodel.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/date_navigation_bar.dart';
import '../widgets/habits_list.dart';
import '../widgets/delete_habit_dialog.dart';
import '../widgets/create_habit_sheet.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);
    final notifier = ref.read(homeViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: HomeAppBar(
        formattedDate: state.formattedDate,
        pageTitle: state.pageTitle,
        showTodayButton: !state.isTodaySelected,
        onTodayPressed: notifier.selectToday,
      ),
      body: state.habits.isEmpty
          ? EmptyState(
        title: 'No habits yet',
        message: 'Create your first habit and start tracking your progress',
        buttonText: 'Create Habit',
        onButtonPressed: () => _showCreateHabitSheet(context, ref),
      )
          : Column(
        children: [
          DateNavigationBar(
            weekday: _getWeekdayShort(state.selectedDate.weekday),
            dateShort: state.formattedDateShort,
            canGoPrevious: true,
            canGoNext: !state.isTodaySelected,
            onPreviousPressed: notifier.selectPreviousDay,
            onNextPressed: notifier.selectNextDay,
          ),
          Expanded(
            child: HabitsList(
              habits: state.habits,
              isCompleted: (habitId) => state.isHabitCompleted(habitId),
              onToggle: (habitId) => notifier.toggleHabitCompletion(habitId),
              onDelete: (habit) => _showDeleteDialog(context, ref, habit),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateHabitSheet(context, ref),
        backgroundColor: AppColors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showCreateHabitSheet(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(homeViewModelProvider.notifier);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CreateHabitSheet(
        availableIcons: notifier.availableIcons,
        availableColors: notifier.availableColorHexCodes,
        validator: notifier.validateHabitName,
        onCreate: (name, icon, color) {
          notifier.createHabit(
            name: name,
            icon: icon,
            accentColor: color,
          );
        },
      ),
    );
  }

  void _showDeleteDialog(
      BuildContext context,
      WidgetRef ref,
      Habit habit,
      ) {
    final notifier = ref.read(homeViewModelProvider.notifier);

    showDialog(
      context: context,
      builder: (context) => DeleteHabitDialog(
        habit: habit,
        onDelete: () => notifier.deleteHabit(habit.id),
      ),
    );
  }

  String _getWeekdayShort(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }
}