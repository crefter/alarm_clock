part of 'timer_bloc.dart';

@freezed
class TimerState with _$TimerState {
  const TimerState._();

  const factory TimerState.initial() = _TimerInitialState;

  const factory TimerState.installed(Time time) = _TimerInstalledState;

  const factory TimerState.started(Time time) = _TimerStartedState;

  const factory TimerState.ticking(Time time) = _TimerTickingState;

  const factory TimerState.stopped(Time time) = _TimerStoppedState;

  Time get time => when(
        initial: () => Time.origin(),
        installed: (time) => time,
        stopped: (time) => time,
        ticking: (time) => time,
        started: (time) => time,
      );
}
