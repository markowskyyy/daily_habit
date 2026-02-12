import 'package:daily_habit/domain/enums/habit_icon.dart';
import 'package:flutter/material.dart';

class IconUtils {
  static IconData fromHabitIcon(HabitIcon icon) {
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