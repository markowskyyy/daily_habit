import 'package:daily_habit/data/providers/completion_provider.dart';
import 'package:daily_habit/data/providers/habit_provider.dart';
import 'package:daily_habit/data/providers/stats_provider.dart';
import 'package:daily_habit/domain/entities/habit_completion.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final progressViewModelProvider = Provider((ref) {
  return ProgressViewModel(
    ref: ref,
  );
});

class ProgressViewModel {
  final Ref _ref;

  ProgressViewModel({
    required Ref ref,
  }) : _ref = ref;


  DateTime get selectedDate => _ref.read(selectedDateProvider);

  void setSelectedDate(DateTime date) {
    _ref.read(selectedDateProvider.notifier).state = date;
  }

  void selectToday() {
    _ref.read(selectedDateProvider.notifier).state = DateTime.now();
  }

  bool isSelectedDateToday() {
    final selected = _ref.read(selectedDateProvider);
    final now = DateTime.now();
    return selected.year == now.year &&
        selected.month == now.month &&
        selected.day == now.day;
  }


  bool isHabitCompleted(String habitId) {
    final date = _ref.read(selectedDateProvider);
    return _ref.read(isHabitCompletedForDateProvider(
        (habitId: habitId, date: date)
    ));
  }

  bool isHabitCompletedOnDate(String habitId, DateTime date) {
    return _ref.read(isHabitCompletedForDateProvider(
        (habitId: habitId, date: date)
    ));
  }

  void toggleHabitCompletion(String habitId) {
    final date = _ref.read(selectedDateProvider);
    _ref.read(completionProvider.notifier).toggleCompletion(habitId, date);
  }

  void toggleHabitCompletionForDate(String habitId, DateTime date) {
    _ref.read(completionProvider.notifier).toggleCompletion(habitId, date);
  }

  List<HabitCompletion> getCompletionsForSelectedDate() {
    return _ref.read(completionsForSelectedDateProvider);
  }

  int getCompletionCountForDate(DateTime date) {
    return _ref.read(completionProvider.notifier)
        .getCompletionsForDate(date).length;
  }


  WeeklyStats getWeeklyStats() {
    return _ref.read(weeklyStatsProvider);
  }

  String getWeeklyConsistency() {
    final stats = _ref.read(weeklyStatsProvider);
    return '${stats.weeklyConsistency.round()}%';
  }

  Weekday getBestDay() {
    final stats = _ref.read(weeklyStatsProvider);
    return stats.bestDay;
  }

  int getTotalCheckins() {
    final stats = _ref.read(weeklyStatsProvider);
    return stats.totalCheckins;
  }

  List<double> getWeeklyChartData() {
    final stats = _ref.read(weeklyStatsProvider);
    final maxValue = stats.dailyCompletions.values.isNotEmpty
        ? stats.dailyCompletions.values.reduce((a, b) => a > b ? a : b)
        : 1;

    return [
      (stats.dailyCompletions[Weekday.monday] ?? 0) / maxValue,
      (stats.dailyCompletions[Weekday.tuesday] ?? 0) / maxValue,
      (stats.dailyCompletions[Weekday.wednesday] ?? 0) / maxValue,
      (stats.dailyCompletions[Weekday.thursday] ?? 0) / maxValue,
      (stats.dailyCompletions[Weekday.friday] ?? 0) / maxValue,
      (stats.dailyCompletions[Weekday.saturday] ?? 0) / maxValue,
      (stats.dailyCompletions[Weekday.sunday] ?? 0) / maxValue,
    ];
  }

  int getStreakForHabit(String habitId) {
    return _ref.read(streakForHabitProvider(habitId));
  }

  Map<DateTime, int> getMonthlyCompletions(DateTime month) {
    return _ref.read(monthlyCompletionsProvider(month));
  }


  double getTodayProgress() {
    final habits = _ref.read(habitProvider);
    if (habits.isEmpty) return 0.0;

    final today = DateTime.now();
    int completed = 0;

    for (var habit in habits) {
      if (isHabitCompletedOnDate(habit.id, today)) completed++;
    }

    return completed / habits.length;
  }

  String getTodayProgressPercentage() {
    return '${(getTodayProgress() * 100).round()}%';
  }
}