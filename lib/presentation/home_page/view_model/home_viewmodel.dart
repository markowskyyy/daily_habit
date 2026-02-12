import 'package:daily_habit/data/providers/completion_provider.dart';
import 'package:daily_habit/data/providers/habit_provider.dart';
import 'package:daily_habit/domain/enums/habit_icon.dart';
import 'package:daily_habit/presentation/home_page/state/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  return HomeViewModel(ref: ref);
});

class HomeViewModel extends StateNotifier<HomeState> {
  final Ref _ref;

  HomeViewModel({
    required Ref ref,
  }) : _ref = ref,
        super(
        HomeState(
          habits: ref.read(habitProvider),
          selectedDate: ref.read(selectedDateProvider),
          completionsForSelectedDate: {},
        ),
      ) {
    _init();
  }

  void _init() {
    _ref.listen(habitProvider, (_, habits) {
      state = state.copyWith(habits: habits);
    });

    _ref.listen(selectedDateProvider, (_, date) {
      state = state.copyWith(selectedDate: date);
      _updateCompletions();
    });

    _ref.listen(completionProvider, (_, __) {
      _updateCompletions();
    });

    _updateCompletions();
  }

  void _updateCompletions() {
    final date = state.selectedDate;
    final completions = _ref.read(completionProvider);
    final normalizedDate = DateTime(date.year, date.month, date.day);

    final completionMap = <String, bool>{};
    for (var completion in completions) {
      if (completion.normalizedDate == normalizedDate) {
        completionMap[completion.habitId] = true;
      }
    }

    state = state.copyWith(completionsForSelectedDate: completionMap);
  }

  void selectToday() {
    _ref.read(selectedDateProvider.notifier).state = DateTime.now();
  }

  void selectPreviousDay() {
    final current = state.selectedDate;
    _ref.read(selectedDateProvider.notifier).state =
        current.subtract(const Duration(days: 1));
  }

  void selectNextDay() {
    final current = state.selectedDate;
    final tomorrow = current.add(const Duration(days: 1));
    if (!tomorrow.isAfter(DateTime.now())) {
      _ref.read(selectedDateProvider.notifier).state = tomorrow;
    }
  }

  void toggleHabitCompletion(String habitId) {
    _ref.read(completionProvider.notifier).toggleCompletion(habitId, state.selectedDate);
  }

  void deleteHabit(String habitId) {
    _ref.read(habitProvider.notifier).deleteHabit(habitId);
    _ref.read(completionProvider.notifier).clearCompletionsForHabit(habitId);
  }

  void createHabit({
    required String name,
    required HabitIcon icon,
    required String accentColor,
  }) {
    if (name.trim().isEmpty) return;
    _ref.read(habitProvider.notifier).addHabit(
      name: name.trim(),
      icon: icon,
      accentColor: accentColor,
    );
  }

  String? validateHabitName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Habit name is required';
    }
    if (value.trim().length < 3) {
      return 'Habit name must be at least 3 characters';
    }
    final trimmedName = value.trim().toLowerCase();
    final exists = state.habits.any((habit) =>
    habit.name.toLowerCase() == trimmedName
    );
    if (exists) {
      return 'Habit with this name already exists';
    }
    return null;
  }

  List<HabitIcon> get availableIcons => HabitIcon.values;

  List<String> get availableColorHexCodes => const [
    '#9C27B0', '#29B6F6', '#66BB6A', '#FFA726',
    '#EF5350', '#EC407A', '#5C6BC0', '#26A69A',
  ];

  IconData getIconData(HabitIcon icon) {
    switch (icon) {
      case HabitIcon.yoga:
        return Icons.self_improvement;
      case HabitIcon.book:
        return Icons.menu_book;
      case HabitIcon.water:
        return Icons.water_drop;
      case HabitIcon.meditation:
        return Icons.self_improvement;
      case HabitIcon.workout:
        return Icons.fitness_center;
      case HabitIcon.running:
        return Icons.directions_run;
      case HabitIcon.sleep:
        return Icons.night_shelter;
      case HabitIcon.healthyFood:
        return Icons.restaurant;
    }
  }
}