import 'package:alarm_clock/src/features/clock/src/domain/clock.dart';
import 'package:alarm_clock/src/features/clock/src/domain/clock_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'clock_event.dart';

part 'clock_state.dart';

part 'clock_bloc.freezed.dart';

class ClockBloc extends Bloc<ClockEvent, ClockState> {
  final ClockRepository _clockRepository;

  ClockBloc(this._clockRepository) : super(const ClockState.initial()) {
    on<ClockEvent>((event, emit) async {
      await event.map<Future<void>>(
        tick: (event) => _onTick(event, emit),
        throwError: (event) => _onThrowError(event, emit),
      );
    });
    _clockRepository.getTime().listen(
          (clock) {
        add(ClockEvent.tick(clock));
      },
      onError: (e, stackTrace) {
        add(ClockEvent.throwError(e.toString()));
      },
    );
  }

  Future<void> _onTick(_ClockTickEvent event, Emitter<ClockState> emit) async {
    final clock = event.clock;
    final newState = state.maybeWhen<ClockState>(
      initial: () => ClockState.loaded(clock),
      loaded: (currentClock) => ClockState.loaded(clock),
      orElse: () => const ClockState.initial(),
    );
    emit(newState);
  }

  Future<void> _onThrowError(
      _ClockThrowErrorEvent event, Emitter<ClockState> emit) async {
    emit(ClockState.error(event.message));
  }
}
