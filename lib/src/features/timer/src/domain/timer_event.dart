part of 'timer_bloc.dart';

@freezed
class TimerEvent with _$TimerEvent {
  const factory TimerEvent.start() = _TimerStartEvent;

  const factory TimerEvent.stop() = _TimerStopEvent;

  const factory TimerEvent.set(int hours, int minutes, int seconds) =
      _TimerSetEvent;

  const factory TimerEvent.reset() = _TimerResetEvent;

  const factory TimerEvent.tick() = _TimerTickEvent;
}
