import 'package:daily_habit/data/providers/completion_provider.dart';
import 'package:daily_habit/data/providers/habit_provider.dart';
import 'package:daily_habit/data/providers/stats_provider.dart';
import 'package:daily_habit/domain/entities/habit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final statsViewModelProvider = Provider((ref) {
  return StatsViewModel(
    ref: ref,
  );
});

class StatsViewModel {
  final Ref _ref;

  StatsViewModel({
    required Ref ref,
  }) : _ref = ref;

  // Getters
  WeeklyStats get weeklyStats => _ref.read(weeklyStatsProvider);
  List<Habit> get habits => _ref.read(habitProvider);
  bool get hasData => habits.isNotEmpty;
  int get totalCompletions => _ref.read(totalCompletionsAllTimeProvider);

  // Weekly stats
  String get weeklyConsistency {
    return '${weeklyStats.weeklyConsistency.round()}%';
  }

  String get bestDay {
    return weeklyStats.bestDay.shortName;
  }

  int get totalCheckins {
    return weeklyStats.totalCheckins;
  }

  int get habitsCount {
    return habits.length;
  }

  // Chart data
  List<double> get weeklyChartData {
    final stats = weeklyStats;
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

  List<String> get weeklyLabels {
    return ['Пн', 'Вт', 'Ср', 'Чет', 'Пят', 'Суб', 'Вс'];
  }

  // Streaks
  int getLongestStreak() {
    int longest = 0;
    for (var habit in habits) {
      final streak = _ref.read(streakForHabitProvider(habit.id));
      if (streak > longest) longest = streak;
    }
    return longest;
  }

  int getActiveStreaksCount() {
    int count = 0;
    for (var habit in habits) {
      final streak = _ref.read(streakForHabitProvider(habit.id));
      if (streak > 0) count++;
    }
    return count;
  }

  String get longestStreakFormatted {
    final streak = getLongestStreak();
    return '$streak days';
  }

  String get activeStreaksFormatted {

    return '${getActiveStreaksCount()}/${habits.length}';
  }

  // Most completed habits
  Map<Habit, int> getMostCompletedHabits({int limit = 3}) {
    final completions = _ref.read(completionProvider);

    final completionCounts = <String, int>{};
    for (var completion in completions) {
      completionCounts[completion.habitId] =
          (completionCounts[completion.habitId] ?? 0) + 1;
    }

    final sortedHabits = habits
        .where((h) => completionCounts.containsKey(h.id))
        .toList()
      ..sort((a, b) =>
          (completionCounts[b.id] ?? 0).compareTo(completionCounts[a.id] ?? 0)
      );

    final result = <Habit, int>{};
    for (var i = 0; i < sortedHabits.length && i < limit; i++) {
      final habit = sortedHabits[i];
      result[habit] = completionCounts[habit.id] ?? 0;
    }

    return result;
  }

  // Habit stats
  int getHabitCompletionCount(String habitId) {
    final completions = _ref.read(completionProvider);
    return completions.where((c) => c.habitId == habitId).length;
  }

  int getHabitStreak(String habitId) {
    return _ref.read(streakForHabitProvider(habitId));
  }

  double getHabitCompletionRate(String habitId) {
    final habit = habits.firstWhere((h) => h.id == habitId);
    final daysSinceCreated = DateTime.now().difference(habit.createdAt).inDays + 1;
    final completions = getHabitCompletionCount(habitId);

    if (daysSinceCreated == 0) return 0.0;
    return (completions / daysSinceCreated) * 100;
  }

  // Overall stats
  double getOverallCompletionRate() {
    if (habits.isEmpty) return 0.0;

    double total = 0;
    for (var habit in habits) {
      total += getHabitCompletionRate(habit.id);
    }
    return total / habits.length;
  }

  String getOverallCompletionRateFormatted () {
    return '${getOverallCompletionRate().round()}%';
  }

  int getTotalDaysTracked() {
    if (habits.isEmpty) return 0;

    final firstHabit = habits.reduce(
            (a, b) => a.createdAt.isBefore(b.createdAt) ? a : b
    );
    return DateTime.now().difference(firstHabit.createdAt).inDays + 1;
  }
}