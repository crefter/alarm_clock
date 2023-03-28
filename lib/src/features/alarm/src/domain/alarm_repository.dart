import 'package:alarm_clock/src/features/alarm/src/domain/alarm.dart';

abstract class AlarmRepository {
  Future<List<Alarm>> get();
  Future<void> save(List<Alarm> alarms);
}