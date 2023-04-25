import 'dart:async';

import 'package:alarm_clock/src/features/timer/src/domain/time.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_event.dart';

part 'timer_state.dart';

part 'timer_bloc.freezed.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  late Timer _timer;

  TimerBloc() : super(const TimerState.initial()) {
    on<TimerEvent>((event, emit) async {
      await event.map(
        start: (event) => _onStart(event, emit),
        stop: (event) => _onStop(event, emit),
        tick: (event) => _onTick(event, emit),
        set: (event) => _onSet(event, emit),
        reset: (event) => _onReset(event, emit),
      );
    });
  }

  Future<void> _onStart(
    _TimerStartEvent event,
    Emitter<TimerState> emit,
  ) async {
    final time = state.time;
    if (time.seconds != 0) {
      emit(TimerState.started(time));
      _timer = Timer.periodic(
        const Duration(
          seconds: 1,
        ),
            (timer) {
          add(const TimerEvent.tick());
        },
      );
    }
  }

  Future<void> _onStop(
    _TimerStopEvent event,
    Emitter<TimerState> emit,
  ) async {
    final time = state.time;
    emit(TimerState.stopped(time));
    _timer.cancel();
  }

  Future<void> _onTick(
    _TimerTickEvent event,
    Emitter<TimerState> emit,
  ) async {
    final time = state.time;
    if (time.seconds != 0) {
      final newTime = time.copyWith(time.hours, time.minutes, time.seconds - 1);
      emit(TimerState.ticking(newTime));
      return;
    }
    if (time.minutes != 0) {
      final newTime = time.copyWith(time.hours, time.minutes - 1, 59);
      emit(TimerState.ticking(newTime));
      return;
    }
    if (time.hours != 0) {
      final newTime = time.copyWith(time.hours - 1, 59, 59);
      emit(TimerState.ticking(newTime));
      return;
    }
    add(const TimerEvent.reset());
  }

  Future<void> _onSet(
    _TimerSetEvent event,
    Emitter<TimerState> emit,
  ) async {
    Time time = Time(
      event.hours,
      event.minutes,
      event.seconds,
    );
    emit(TimerState.installed(time));
  }

  Future<void> _onReset(
    _TimerResetEvent event,
    Emitter<TimerState> emit,
  ) async {
    _timer.cancel();
    emit(const TimerState.initial());
  }
}
