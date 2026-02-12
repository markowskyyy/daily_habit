import 'package:daily_habit/domain/entities/habit.dart';
import 'package:daily_habit/domain/entities/habit_completion.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'habit_provider.dart';
import 'completion_provider.dart';

enum Weekday {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

extension WeekdayExtension on Weekday {
  String get shortName {
    switch (this) {
      case Weekday.monday:
        return 'Пон';
      case Weekday.tuesday:
        return 'Вт';
      case Weekday.wednesday:
        return 'Ср';
      case Weekday.thursday:
        return 'Чт';
      case Weekday.friday:
        return 'Пт';
      case Weekday.saturday:
        return 'Сб';
      case Weekday.sunday:
        return 'Вс';
    }
  }

  String get fullName {
    switch (this) {
      case Weekday.monday:
        return 'Понедельник';
      case Weekday.tuesday:
        return 'Вторник';
      case Weekday.wednesday:
        return 'Среда';
      case Weekday.thursday:
        return 'Четверг';
      case Weekday.friday:
        return 'Пятницу';
      case Weekday.saturday:
        return 'Суббота';
      case Weekday.sunday:
        return 'Воскресенье';
    }
  }
}

class WeeklyStats {
  final double weeklyConsistency;
  final Map<Weekday, int> dailyCompletions;
  final Weekday bestDay;
  final int totalCheckins;

  WeeklyStats({
    required this.weeklyConsistency,
    required this.dailyCompletions,
    required this.bestDay,
    required this.totalCheckins,
  });

  WeeklyStats.empty()
      : weeklyConsistency = 0,
        dailyCompletions = {},
        bestDay = Weekday.monday,
        totalCheckins = 0;
}

final weeklyStatsProvider = Provider<WeeklyStats>((ref) {
  final habits = ref.watch(habitProvider);
  final completions = ref.watch(completionProvider);
  final now = DateTime.now();

  return _calculateWeeklyStats(habits, completions, now);
});

final monthlyCompletionsProvider = Provider.family<Map<DateTime, int>, DateTime>((ref, date) {
  final completions = ref.watch(completionProvider);
  final year = date.year;
  final month = date.month;

  final monthCompletions = <DateTime, int>{};

  for (var completion in completions) {
    if (completion.date.year == year && completion.date.month == month) {
      final day = DateTime(year, month, completion.date.day);
      monthCompletions[day] = (monthCompletions[day] ?? 0) + 1;
    }
  }

  return monthCompletions;
});

final streakForHabitProvider = Provider.family<int, String>((ref, habitId) {
  final completions = ref.watch(completionProvider);
  final now = DateTime.now();

  final habitCompletions = completions
      .where((c) => c.habitId == habitId)
      .map((c) => c.normalizedDate)
      .toSet()
      .toList()
    ..sort((a, b) => b.compareTo(a)); // сортируем от новых к старым

  if (habitCompletions.isEmpty) return 0;

  int streak = 0;
  var currentDate = now;

  while (true) {
    final dateToCheck = DateTime(currentDate.year, currentDate.month, currentDate.day);

    if (habitCompletions.contains(dateToCheck)) {
      streak++;
      currentDate = currentDate.subtract(const Duration(days: 1));
    } else {
      break;
    }
  }

  return streak;
});

final totalCompletionsAllTimeProvider = Provider<int>((ref) {
  final completions = ref.watch(completionProvider);
  return completions.length;
});

WeeklyStats _calculateWeeklyStats(
    List<Habit> habits,
    List<HabitCompletion> completions,
    DateTime now,
    ) {
  // Получаем даты за последние 7 дней
  final last7Days = List.generate(7, (index) {
    return now.subtract(Duration(days: 6 - index));
  });

  // Инициализируем счетчики по дням недели
  final dailyCounts = <Weekday, int>{
    Weekday.monday: 0,
    Weekday.tuesday: 0,
    Weekday.wednesday: 0,
    Weekday.thursday: 0,
    Weekday.friday: 0,
    Weekday.saturday: 0,
    Weekday.sunday: 0,
  };

  int totalCompletions = 0;

  for (var day in last7Days) {
    final weekday = _getWeekdayFromDateTime(day);
    final normalizedDay = DateTime(day.year, day.month, day.day);

    final dayCompletions = completions.where((c) {
      return c.normalizedDate == normalizedDay;
    }).length;

    dailyCounts[weekday] = (dailyCounts[weekday] ?? 0) + dayCompletions;
    totalCompletions += dayCompletions;
  }

  // Находим лучший день
  Weekday bestDay = Weekday.monday;
  int maxCompletions = 0;

  dailyCounts.forEach((weekday, count) {
    if (count > maxCompletions) {
      maxCompletions = count;
      bestDay = weekday;
    }
  });

  // Считаем консистенцию (макс возможное = habits.length * 7)
  final maxPossible = habits.length * 7;
  final consistency = maxPossible > 0
      ? (totalCompletions / maxPossible * 100)
      : 0.0;

  // Округляем до целого числа
  final roundedConsistency = (consistency * 100).roundToDouble() / 100;

  return WeeklyStats(
    weeklyConsistency: roundedConsistency,
    dailyCompletions: dailyCounts,
    bestDay: bestDay,
    totalCheckins: totalCompletions,
  );
}

Weekday _getWeekdayFromDateTime(DateTime date) {
  switch (date.weekday) {
    case DateTime.monday:
      return Weekday.monday;
    case DateTime.tuesday:
      return Weekday.tuesday;
    case DateTime.wednesday:
      return Weekday.wednesday;
    case DateTime.thursday:
      return Weekday.thursday;
    case DateTime.friday:
      return Weekday.friday;
    case DateTime.saturday:
      return Weekday.saturday;
    case DateTime.sunday:
      return Weekday.sunday;
    default:
      return Weekday.monday;
  }
}