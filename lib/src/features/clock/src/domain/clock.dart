class Clock {
  final int hours;
  final int minutes;
  final String timeZone;
  final String date;

  Clock({
    required this.hours,
    required this.minutes,
    required this.timeZone,
    required this.date,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Clock &&
          runtimeType == other.runtimeType &&
          hours == other.hours &&
          minutes == other.minutes &&
          timeZone == other.timeZone &&
          date == other.date;

  @override
  int get hashCode =>
      hours.hashCode ^ minutes.hashCode ^ timeZone.hashCode ^ date.hashCode;
}
