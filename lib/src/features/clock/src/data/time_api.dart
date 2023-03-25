import 'package:alarm_clock/src/features/clock/src/data/month_mapper.dart';
import 'package:alarm_clock/src/features/clock/src/data/number_weekday_to_name_mapper.dart';
import 'package:alarm_clock/src/features/clock/src/data/time_dto.dart';

class TimeApi {
  final NumberWeekdayToNameMapper dayMapper;
  final MonthMapper monthMapper;

  TimeApi({required this.dayMapper, required this.monthMapper});

  Future<TimeDto> getTime() async {
    final now = DateTime.now();
    final dayName = dayMapper.map(now.weekday);
    final month = monthMapper.map(now.month);
    final String date = '$month ${now.day} $dayName';
    return TimeDto(now.hour, now.minute, now.toLocal().timeZoneName, date);
  }
}
