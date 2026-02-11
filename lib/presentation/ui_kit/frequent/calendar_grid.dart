import 'package:daily_habit/core/consts/design.dart';
import 'package:flutter/material.dart';


class CalendarGrid extends StatelessWidget {
  final DateTime currentMonth;
  final Map<DateTime, int> completionCounts;
  final Function(DateTime) onDaySelected;
  final DateTime? selectedDate;

  const CalendarGrid({
    super.key,
    required this.currentMonth,
    required this.completionCounts,
    required this.onDaySelected,
    this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateTime(currentMonth.year, currentMonth.month + 1, 0).day;
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final firstWeekday = firstDayOfMonth.weekday;

    return Column(
      children: [
        _buildWeekdayHeaders(),
        const SizedBox(height: 8),
        _buildCalendarGrid(daysInMonth, firstWeekday),
      ],
    );
  }

  Widget _buildWeekdayHeaders() {
    const weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekdays.map((day) {
        return SizedBox(
          width: 40,
          child: Text(
            day,
            textAlign: TextAlign.center,
            style: AppTextStyles.calendarWeekday,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCalendarGrid(int daysInMonth, int firstWeekday) {
    final List<Widget> dayWidgets = [];

    for (int i = 1; i < firstWeekday; i++) {
      dayWidgets.add(_buildEmptyDay());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(currentMonth.year, currentMonth.month, day);
      final isSelected = selectedDate != null &&
          selectedDate!.year == date.year &&
          selectedDate!.month == date.month &&
          selectedDate!.day == date.day;

      dayWidgets.add(_buildDay(day, date, isSelected));
    }

    final totalCells = dayWidgets.length;
    final remainingCells = 42 - totalCells;
    for (int i = 0; i < remainingCells; i++) {
      dayWidgets.add(_buildEmptyDay());
    }

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 7,
      childAspectRatio: 1,
      children: dayWidgets,
    );
  }

  Widget _buildEmptyDay() {
    return Container(
      margin: const EdgeInsets.all(2),
      child: const SizedBox(),
    );
  }

  Widget _buildDay(int day, DateTime date, bool isSelected) {
    final completionCount = completionCounts[date] ?? 0;
    final hasCompletions = completionCount > 0;

    return GestureDetector(
      onTap: () => onDaySelected(date),
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected
              ? AppColors.green.withOpacity(0.2)
              : null,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              day.toString(),
              style: AppTextStyles.calendarDay.copyWith(
                color: isSelected ? AppColors.green : AppColors.darkText,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (hasCompletions)
              Positioned(
                bottom: 4,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.green,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}