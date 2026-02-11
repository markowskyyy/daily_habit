import 'package:daily_habit/data/providers/completion_provider.dart';
import 'package:daily_habit/data/providers/habit_provider.dart';
import 'package:daily_habit/domain/entities/habit_completion.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final completionViewModelProvider = Provider((ref) {
  return CompletionViewModel(
    ref: ref,
  );
});

class CompletionViewModel {
  final Ref _ref;

  CompletionViewModel({
    required Ref ref,
  }) : _ref = ref;

  // Публичные геттеры
  List<HabitCompletion> get allCompletions => _ref.read(completionProvider);
  DateTime get selectedDate => _ref.read(selectedDateProvider);

  // Observable
  AsyncValue<DateTime> watchSelectedDate() {
    return AsyncValue.data(_ref.watch(selectedDateProvider));
  }

  AsyncValue<List<HabitCompletion>> watchCompletionsForSelectedDate() {
    return AsyncValue.data(_ref.watch(completionsForSelectedDateProvider));
  }

  // Управление датой
  void setSelectedDate(DateTime date) {
    _ref.read(selectedDateProvider.notifier).state = date;
  }

  void selectToday() {
    _ref.read(selectedDateProvider.notifier).state = DateTime.now();
  }

  void selectPreviousDay() {
    final current = _ref.read(selectedDateProvider);
    _ref.read(selectedDateProvider.notifier).state =
        current.subtract(const Duration(days: 1));
  }

  void selectNextDay() {
    final current = _ref.read(selectedDateProvider);
    final tomorrow = current.add(const Duration(days: 1));
    if (!tomorrow.isAfter(DateTime.now())) {
      _ref.read(selectedDateProvider.notifier).state = tomorrow;
    }
  }

  // Toggle completion
  void toggleHabitCompletion(String habitId) {
    final date = _ref.read(selectedDateProvider);
    _ref.read(completionProvider.notifier).toggleCompletion(habitId, date);
  }

  void toggleHabitCompletionForDate(String habitId, DateTime date) {
    _ref.read(completionProvider.notifier).toggleCompletion(habitId, date);
  }

  // Проверка статуса
  bool isHabitCompletedToday(String habitId) {
    final date = DateTime.now();
    return _ref.read(isHabitCompletedForDateProvider(
        (habitId: habitId, date: date)
    ));
  }

  bool isHabitCompletedOnDate(String habitId, DateTime date) {
    return _ref.read(isHabitCompletedForDateProvider(
        (habitId: habitId, date: date)
    ));
  }

  // Статистика завершений
  int getCompletionCountForDate(DateTime date) {
    return _ref.read(completionProvider.notifier)
        .getCompletionsForDate(date).length;
  }

  int getCompletionCountForHabitOnDate(String habitId, DateTime date) {
    return _ref.read(completionProvider.notifier)
        .getCompletionCountForDate(habitId, date);
  }

  List<HabitCompletion> getCompletionsForMonth(int year, int month) {
    return _ref.read(completionProvider.notifier)
        .getCompletionsForMonth(year, month);
  }

  // Bulk операции
  void completeAllHabitsForToday() {
    final habits = _ref.read(habitProvider);
    final today = DateTime.now();

    for (var habit in habits) {
      _ref.read(completionProvider.notifier)
          .completeHabit(habit.id, today);
    }
  }

  void uncompleteAllHabitsForToday() {
    final habits = _ref.read(habitProvider);
    final today = DateTime.now();

    for (var habit in habits) {
      _ref.read(completionProvider.notifier)
          .uncompleteHabit(habit.id, today);
    }
  }

  // Прогресс дня
  double getTodayProgress() {
    final habits = _ref.read(habitProvider);
    if (habits.isEmpty) return 0.0;

    final today = DateTime.now();
    int completedCount = 0;

    for (var habit in habits) {
      if (isHabitCompletedOnDate(habit.id, today)) {
        completedCount++;
      }
    }

    return completedCount / habits.length;
  }

  String getTodayProgressPercentage() {
    final progress = getTodayProgress();
    return '${(progress * 100).round()}%';
  }

  // Проверка на сегодня
  bool isSelectedDateToday() {
    final selected = _ref.read(selectedDateProvider);
    final now = DateTime.now();
    return selected.year == now.year &&
        selected.month == now.month &&
        selected.day == now.day;
  }

  bool isSelectedDateFuture() {
    final selected = _ref.read(selectedDateProvider);
    final now = DateTime.now();
    return selected.isAfter(DateTime(now.year, now.month, now.day));
  }
}