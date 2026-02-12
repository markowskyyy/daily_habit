import 'dart:convert';
import 'package:daily_habit/domain/entities/habit_completion.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  CompletionNotifier() : super([]) {
    _loadCompletions();
  }

  static const String _storageKey = 'completions';

  Future<void> _loadCompletions() async {
    final prefs = await SharedPreferences.getInstance();
    final String? completionsJson = prefs.getString(_storageKey);

    if (completionsJson != null) {
      final List<dynamic> decoded = json.decode(completionsJson);
      state = decoded.map((item) => HabitCompletion.fromJson(item)).toList();
    }
  }

  Future<void> _saveCompletions() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = json.encode(state.map((c) => c.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
  }

  void toggleCompletion(String habitId, DateTime date) async {
    final normalizedDate = DateTime(date.year, date.month, date.day);

    final existingIndex = state.indexWhere(
            (completion) => completion.habitId == habitId &&
            completion.normalizedDate == normalizedDate
    );

    if (existingIndex >= 0) {
      state = [
        ...state.sublist(0, existingIndex),
        ...state.sublist(existingIndex + 1),
      ];
    } else {
      state = [
        ...state,
        HabitCompletion(
          habitId: habitId,
          date: normalizedDate,
        ),
      ];
    }
    await _saveCompletions();
  }

  void completeHabit(String habitId, DateTime date) async {
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
      await _saveCompletions();
    }
  }

  void uncompleteHabit(String habitId, DateTime date) async {
    final normalizedDate = DateTime(date.year, date.month, date.day);

    state = state.where((completion) {
      return !(completion.habitId == habitId &&
          completion.normalizedDate == normalizedDate);
    }).toList();
    await _saveCompletions();
  }

  void clearCompletionsForHabit(String habitId) async {
    state = state.where((completion) => completion.habitId != habitId).toList();
    await _saveCompletions();
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

  void clearAllCompletions() async {
    state = [];
    await _saveCompletions();
  }
}