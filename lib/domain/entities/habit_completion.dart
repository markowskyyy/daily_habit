class HabitCompletion {
  final String habitId;
  final DateTime date;
  final bool isCompleted;

  HabitCompletion({
    required this.habitId,
    required this.date,
    this.isCompleted = true,
  });

  DateTime get normalizedDate => DateTime(date.year, date.month, date.day);

  HabitCompletion copyWith({
    String? habitId,
    DateTime? date,
    bool? isCompleted,
  }) {
    return HabitCompletion(
      habitId: habitId ?? this.habitId,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is HabitCompletion &&
              runtimeType == other.runtimeType &&
              habitId == other.habitId &&
              normalizedDate == other.normalizedDate;

  @override
  int get hashCode => habitId.hashCode ^ normalizedDate.hashCode;
}