part of 'clock_bloc.dart';

@freezed
class ClockState with _$ClockState {
  const factory ClockState.initial() = _ClockInitialState;
  const factory ClockState.loaded(Clock clock) = _ClockLoadedState;
  const factory ClockState.error(String error) = _ClockErrorState;
}
