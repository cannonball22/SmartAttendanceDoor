enum DayOfTheWeek {
  sunday,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
}

extension DayOfTheWeekExtension on DayOfTheWeek {
  String get name {
    switch (this) {
      case DayOfTheWeek.sunday:
        return 'Sunday';
      case DayOfTheWeek.monday:
        return 'Monday';
      case DayOfTheWeek.tuesday:
        return 'Tuesday';
      case DayOfTheWeek.wednesday:
        return 'Wednesday';
      case DayOfTheWeek.thursday:
        return 'Thursday';
      case DayOfTheWeek.friday:
        return 'Friday';
      case DayOfTheWeek.saturday:
        return 'Saturday';
    }
  }
}
