import 'dart:convert';
import 'package:daily_habit/domain/entities/habit.dart';
import 'package:daily_habit/domain/enums/habit_icon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final habitProvider = StateNotifierProvider<HabitNotifier, List<Habit>>((ref) {
  return HabitNotifier();
});

class HabitNotifier extends StateNotifier<List<Habit>> {
  HabitNotifier() : super([]) {
    _loadHabits();
  }

  static const String _storageKey = 'habits';

  Future<void> _loadHabits() async {
    final prefs = await SharedPreferences.getInstance();
    final String? habitsJson = prefs.getString(_storageKey);

    if (habitsJson != null) {
      final List<dynamic> decoded = json.decode(habitsJson);
      state = decoded.map((item) => Habit.fromJson(item)).toList();
    }
  }

  Future<void> _saveHabits() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = json.encode(state.map((h) => h.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
  }

  void addHabit({
    required String name,
    required HabitIcon icon,
    required String accentColor,
  }) async {
    final newHabit = Habit(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      icon: icon,
      accentColor: accentColor,
      createdAt: DateTime.now(),
    );

    state = [...state, newHabit];
    await _saveHabits();
  }

  void deleteHabit(String id) async {
    state = state.where((habit) => habit.id != id).toList();
    await _saveHabits();
  }

  void updateHabit(Habit updatedHabit) async {
    state = state.map((habit) {
      return habit.id == updatedHabit.id ? updatedHabit : habit;
    }).toList();
    await _saveHabits();
  }

  void clearAllHabits() async {
    state = [];
    await _saveHabits();
  }
}