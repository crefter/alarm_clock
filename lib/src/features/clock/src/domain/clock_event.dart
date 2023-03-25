part of 'clock_bloc.dart';

@freezed
class ClockEvent with _$ClockEvent {
  const factory ClockEvent.start() = _ClockStartEvent;

  const factory ClockEvent.tick(Clock clock) = _ClockTickEvent;

  const factory ClockEvent.throwError(String message) =
      _ClockThrowErrorEvent;
}
