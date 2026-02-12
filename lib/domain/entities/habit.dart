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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon.index,
      'accentColor': accentColor,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id'],
      name: json['name'],
      icon: HabitIcon.values[json['icon']],
      accentColor: json['accentColor'],
      createdAt: DateTime.parse(json['createdAt']),
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