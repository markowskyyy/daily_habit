import 'package:daily_habit/data/providers/completion_provider.dart';
import 'package:daily_habit/data/providers/habit_provider.dart';
import 'package:daily_habit/domain/entities/habit.dart';
import 'package:daily_habit/domain/enums/habit_icon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final habitViewModelProvider = Provider((ref) {
  return HabitViewModel(
    ref: ref,
  );
});

class HabitViewModel {
  final Ref _ref;

  HabitViewModel({
    required Ref ref,
  }) : _ref = ref;

  List<Habit> get habits => _ref.read(habitProvider);

  AsyncValue<List<Habit>> watchHabits() {
    return AsyncValue.data(_ref.watch(habitProvider));
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

  void deleteHabit(String habitId) {
    _ref.read(habitProvider.notifier).deleteHabit(habitId);
    _ref.read(completionProvider.notifier).clearCompletionsForHabit(habitId);
  }

  Habit? getHabitById(String habitId) {
    try {
      return habits.firstWhere((habit) => habit.id == habitId);
    } catch (e) {
      return null;
    }
  }

  bool isHabitNameValid(String name) {
    return name.trim().isNotEmpty && name.trim().length >= 3;
  }

  bool isHabitNameUnique(String name) {
    final trimmedName = name.trim().toLowerCase();
    return !habits.any((habit) =>
    habit.name.toLowerCase() == trimmedName
    );
  }

  List<HabitIcon> get availableIcons => HabitIcon.values;


  String? validateHabitName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Habit name is required';
    }

    if (value.trim().length < 3) {
      return 'Habit name must be at least 3 characters';
    }

    if (!isHabitNameUnique(value)) {
      return 'Habit with this name already exists';
    }

    return null;
  }

  List<String> get availableColorHexCodes => [
    '#9C27B0', '#29B6F6', '#66BB6A', '#FFA726',
    '#EF5350', '#EC407A', '#5C6BC0', '#26A69A',
  ];
}