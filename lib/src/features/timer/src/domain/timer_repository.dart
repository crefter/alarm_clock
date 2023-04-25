import 'package:alarm_clock/src/features/timer/src/domain/time.dart';

abstract class TimerRepository {
  Future<Time> get();

  Future<void> save(Time time);
}
