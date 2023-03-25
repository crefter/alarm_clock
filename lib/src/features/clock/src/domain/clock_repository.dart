import 'package:alarm_clock/src/features/clock/src/domain/clock.dart';

abstract class ClockRepository {
  Stream<Clock> getTime();
}