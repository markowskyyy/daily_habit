
enum HabitIcon {
  yoga,
  book,
  water,
  meditation,
  workout,
  running,
  sleep,
  healthyFood,
}

extension HabitIconExtension on HabitIcon {
  String get iconPath {
    switch (this) {
      case HabitIcon.yoga:
        return 'assets/icons/yoga.svg';
      case HabitIcon.book:
        return 'assets/icons/book.svg';
      case HabitIcon.water:
        return 'assets/icons/water.svg';
      case HabitIcon.meditation:
        return 'assets/icons/meditation.svg';
      case HabitIcon.workout:
        return 'assets/icons/workout.svg';
      case HabitIcon.running:
        return 'assets/icons/running.svg';
      case HabitIcon.sleep:
        return 'assets/icons/sleep.svg';
      case HabitIcon.healthyFood:
        return 'assets/icons/healthy_food.svg';
    }
  }
}