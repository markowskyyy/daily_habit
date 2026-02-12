import 'package:daily_habit/core/consts/design.dart';
import 'package:daily_habit/domain/entities/habit.dart';
import 'package:daily_habit/presentation/pages/home_page/view_model/home_viewmodel.dart';
import 'package:daily_habit/presentation/pages/home_page/widgets/create_habit_sheet.dart';
import 'package:daily_habit/presentation/pages/home_page/widgets/date_navigation_bar.dart';
import 'package:daily_habit/presentation/pages/home_page/widgets/delete_habit_dialog.dart';
import 'package:daily_habit/presentation/pages/home_page/widgets/habits_list.dart';
import 'package:daily_habit/presentation/pages/home_page/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


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
      body: Column(
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
        return 'Пон';
      case DateTime.tuesday:
        return 'Вт';
      case DateTime.wednesday:
        return 'Ср';
      case DateTime.thursday:
        return 'Чт';
      case DateTime.friday:
        return 'Пт';
      case DateTime.saturday:
        return 'Суб';
      case DateTime.sunday:
        return 'Вс';
      default:
        return '';
    }
  }
}