

import 'package:daily_habit/domain/entities/habit_completion.dart';
import 'package:daily_habit/domain/enums/habit_icon.dart';

class Habit {
  final String id;
  final String name;
  final HabitIcon icon;
  final String accentColor;
  final DateTime createdAt;
  final List<HabitCompletion> completions;

  Habit({
    required this.id,
    required this.name,
    required this.icon,
    required this.accentColor,
    required this.createdAt,
    this.completions = const [],
  });

  Habit copyWith({
    String? id,
    String? name,
    HabitIcon? icon,
    String? accentColor,
    DateTime? createdAt,
    List<HabitCompletion>? completions,
  }) {
    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      accentColor: accentColor ?? this.accentColor,
      createdAt: createdAt ?? this.createdAt,
      completions: completions ?? this.completions,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Habit &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;
}