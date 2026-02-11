import 'package:daily_habit/domain/entities/habit.dart';
import 'package:daily_habit/domain/enums/habit_icon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final habitProvider = StateNotifierProvider<HabitNotifier, List<Habit>>((ref) {
  return HabitNotifier();
});

class HabitNotifier extends StateNotifier<List<Habit>> {
  HabitNotifier() : super(_initialHabits);

  static final List<Habit> _initialHabits = [
    Habit(
      id: '1',
      name: 'Morning Yoga',
      icon: HabitIcon.yoga,
      accentColor: '#9C27B0', // purple
      createdAt: DateTime.now(),
    ),
    Habit(
      id: '2',
      name: 'Read 20 mins',
      icon: HabitIcon.book,
      accentColor: '#29B6F6', // blue
      createdAt: DateTime.now(),
    ),
    Habit(
      id: '3',
      name: 'Drink 2L Water',
      icon: HabitIcon.water,
      accentColor: '#66BB6A', // green
      createdAt: DateTime.now(),
    ),
  ];

  void addHabit({
    required String name,
    required HabitIcon icon,
    required String accentColor,
  }) {
    final newHabit = Habit(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      icon: icon,
      accentColor: accentColor,
      createdAt: DateTime.now(),
    );

    state = [...state, newHabit];
  }

  void deleteHabit(String id) {
    state = state.where((habit) => habit.id != id).toList();
  }

  void updateHabit(Habit updatedHabit) {
    state = state.map((habit) {
      return habit.id == updatedHabit.id ? updatedHabit : habit;
    }).toList();
  }
}