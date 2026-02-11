import 'package:daily_habit/domain/entities/habit_completion.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final completionProvider = StateNotifierProvider<CompletionNotifier, List<HabitCompletion>>((ref) {
  return CompletionNotifier();
});

final selectedDateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

final completionsForSelectedDateProvider = Provider<List<HabitCompletion>>((ref) {
  final selectedDate = ref.watch(selectedDateProvider);
  final completions = ref.watch(completionProvider);

  final normalizedSelected = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day
  );

  return completions.where((completion) {
    return completion.normalizedDate == normalizedSelected;
  }).toList();
});

final isHabitCompletedForDateProvider = Provider.family<bool, ({String habitId, DateTime date})>((ref, params) {
  final completions = ref.watch(completionProvider);
  final normalizedDate = DateTime(
      params.date.year,
      params.date.month,
      params.date.day
  );

  return completions.any((completion) {
    return completion.habitId == params.habitId &&
        completion.normalizedDate == normalizedDate;
  });
});

class CompletionNotifier extends StateNotifier<List<HabitCompletion>> {
  CompletionNotifier() : super([]);

  void toggleCompletion(String habitId, DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);

    final existingIndex = state.indexWhere(
            (completion) => completion.habitId == habitId &&
            completion.normalizedDate == normalizedDate
    );

    if (existingIndex >= 0) {
      // Удаляем если уже есть
      state = [
        ...state.sublist(0, existingIndex),
        ...state.sublist(existingIndex + 1),
      ];
    } else {
      // Добавляем новое завершение
      state = [
        ...state,
        HabitCompletion(
          habitId: habitId,
          date: normalizedDate,
        ),
      ];
    }
  }

  void completeHabit(String habitId, DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);

    final exists = state.any(
            (completion) => completion.habitId == habitId &&
            completion.normalizedDate == normalizedDate
    );

    if (!exists) {
      state = [
        ...state,
        HabitCompletion(
          habitId: habitId,
          date: normalizedDate,
        ),
      ];
    }
  }

  void uncompleteHabit(String habitId, DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);

    state = state.where((completion) {
      return !(completion.habitId == habitId &&
          completion.normalizedDate == normalizedDate);
    }).toList();
  }

  List<HabitCompletion> getCompletionsForDate(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);

    return state.where((completion) {
      return completion.normalizedDate == normalizedDate;
    }).toList();
  }

  List<HabitCompletion> getCompletionsForMonth(int year, int month) {
    return state.where((completion) {
      return completion.date.year == year &&
          completion.date.month == month;
    }).toList();
  }

  int getCompletionCountForDate(String habitId, DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);

    return state.where((completion) {
      return completion.habitId == habitId &&
          completion.normalizedDate == normalizedDate;
    }).length;
  }

  void clearAllCompletions() {
    state = [];
  }



  void clearCompletionsForHabit(String habitId) {
    state = state.where((completion) => completion.habitId != habitId).toList();
  }

}