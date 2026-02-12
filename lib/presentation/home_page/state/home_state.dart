import 'package:daily_habit/domain/entities/habit.dart';

class HomeState {
  final List<Habit> habits;
  final DateTime selectedDate;
  final Map<String, bool> completionsForSelectedDate;

  HomeState({
    required this.habits,
    required this.selectedDate,
    required this.completionsForSelectedDate,
  });

  HomeState copyWith({
    List<Habit>? habits,
    DateTime? selectedDate,
    Map<String, bool>? completionsForSelectedDate,
  }) {
    return HomeState(
      habits: habits ?? this.habits,
      selectedDate: selectedDate ?? this.selectedDate,
      completionsForSelectedDate: completionsForSelectedDate ?? this.completionsForSelectedDate,
    );
  }

  bool get isTodaySelected {
    final now = DateTime.now();
    return now.year == selectedDate.year &&
        now.month == selectedDate.month &&
        now.day == selectedDate.day;
  }

  String get formattedDate {
    final weekday = _getWeekdayFull(selectedDate.weekday);
    final month = _getMonth(selectedDate.month);
    return '$weekday, $month ${selectedDate.day}';
  }

  String get formattedDateShort {
    return '${selectedDate.day}/${selectedDate.month}';
  }

  String get pageTitle {
    return isTodaySelected ? 'My Day' : 'History';
  }

  bool canSelectNextDay() {
    final tomorrow = selectedDate.add(const Duration(days: 1));
    return !tomorrow.isAfter(DateTime.now());
  }

  bool isHabitCompleted(String habitId) {
    return completionsForSelectedDate[habitId] ?? false;
  }

  int get habitsCount => habits.length;

  // ============ PRIVATE HELPERS ============
  String _getWeekdayFull(int weekday) {
    switch (weekday) {
      case 1: return 'Monday';
      case 2: return 'Tuesday';
      case 3: return 'Wednesday';
      case 4: return 'Thursday';
      case 5: return 'Friday';
      case 6: return 'Saturday';
      case 7: return 'Sunday';
      default: return '';
    }
  }

  String _getMonth(int month) {
    switch (month) {
      case 1: return 'JAN';
      case 2: return 'FEB';
      case 3: return 'MAR';
      case 4: return 'APR';
      case 5: return 'MAY';
      case 6: return 'JUN';
      case 7: return 'JUL';
      case 8: return 'AUG';
      case 9: return 'SEP';
      case 10: return 'OCT';
      case 11: return 'NOV';
      case 12: return 'DEC';
      default: return '';
    }
  }
}
