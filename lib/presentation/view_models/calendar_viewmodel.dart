import 'package:daily_habit/data/providers/completion_provider.dart';
import 'package:daily_habit/data/providers/stats_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final calendarViewModelProvider = Provider((ref) {
  return CalendarViewModel(
    ref: ref,
  );
});

class CalendarViewModel {
  final Ref _ref;

  CalendarViewModel({
    required Ref ref,
  }) : _ref = ref;

  DateTime _currentMonth = DateTime.now();

  DateTime get currentMonth => _currentMonth;

  void setCurrentMonth(DateTime month) {
    _currentMonth = DateTime(month.year, month.month, 1);
  }

  void previousMonth() {
    _currentMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month - 1,
      1,
    );
  }

  void nextMonth() {
    _currentMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month + 1,
      1,
    );
  }

  String get formattedMonthYear {
    switch (_currentMonth.month) {
      case 1: return 'January ${_currentMonth.year}';
      case 2: return 'February ${_currentMonth.year}';
      case 3: return 'March ${_currentMonth.year}';
      case 4: return 'April ${_currentMonth.year}';
      case 5: return 'May ${_currentMonth.year}';
      case 6: return 'June ${_currentMonth.year}';
      case 7: return 'July ${_currentMonth.year}';
      case 8: return 'August ${_currentMonth.year}';
      case 9: return 'September ${_currentMonth.year}';
      case 10: return 'October ${_currentMonth.year}';
      case 11: return 'November ${_currentMonth.year}';
      case 12: return 'December ${_currentMonth.year}';
      default: return '';
    }
  }

  Map<DateTime, int> getMonthlyCompletions() {
    return _ref.read(monthlyCompletionsProvider(_currentMonth));
  }

  void selectDate(DateTime date) {
    _ref.read(selectedDateProvider.notifier).state = date;
  }

  DateTime get selectedDate => _ref.read(selectedDateProvider);

  bool hasCompletions(DateTime date) {
    final completions = _ref.read(monthlyCompletionsProvider(_currentMonth));
    return completions.containsKey(date);
  }

  int getCompletionCount(DateTime date) {
    final completions = _ref.read(monthlyCompletionsProvider(_currentMonth));
    return completions[date] ?? 0;
  }

  List<DateTime> getDaysWithCompletions() {
    final completions = _ref.read(monthlyCompletionsProvider(_currentMonth));
    return completions.keys.toList()..sort();
  }
}