import 'package:alarm_clock/src/features/clock/src/domain/clock.dart';

class TimeDto {
  final int hours;
  final int minutes;
  final String timeZone;
  final String date;

  TimeDto(this.hours, this.minutes, this.timeZone, this.date);

  Clock toClock() {
    return Clock(
      hours: hours,
      minutes: minutes,
      timeZone: timeZone,
      date: date,
    );
  }
}
