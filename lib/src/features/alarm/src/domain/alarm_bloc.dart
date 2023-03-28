import 'package:alarm_clock/src/features/alarm/src/domain/alarm.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'alarm_event.dart';

part 'alarm_state.dart';

part 'alarm_bloc.freezed.dart';

class AlarmBloc extends Bloc<AlarmEvent, AlarmState> {
  AlarmBloc() : super(const AlarmState.initial()) {
    on<AlarmEvent>((event, emit) async {
      await event.map<Future<void>>(
        addAlarm: (event) => _onAddAlarm(event, emit),
        deleteAlarm: (event) => _onDeleteAlarm(event, emit),
        on: (event) => _onOn(event, emit),
        off: (event) => _onOff(event, emit),
        start: (event) => _onStart(event, emit),
      );
    });
  }

  Future<void> _onAddAlarm(
    _AlarmAddAlarmEvent event,
    Emitter<AlarmState> emit,
  ) async {}

  Future<void> _onDeleteAlarm(
    _AlarmDeleteAlarmEvent event,
    Emitter<AlarmState> emit,
  ) async {}

  Future<void> _onOn(
    _AlarmOnEvent event,
    Emitter<AlarmState> emit,
  ) async {
    final list = List.of(
      state.maybeWhen<List<Alarm>>(
        orElse: () => [],
        permissionGranted: (alarms) => alarms,
      ),
    );
    final index = list.indexWhere((element) => element.id == event.id);
    final alarm = list.firstWhere((element) => element.id == event.id);
    final newAlarm = alarm.copyWith(on: true);
    list.removeAt(index);
    list.insert(index, newAlarm);
    emit(AlarmState.permissionGranted(list));
  }

  Future<void> _onOff(
    _AlarmOffEvent event,
    Emitter<AlarmState> emit,
  ) async {
    final list = List.of(
      state.maybeWhen<List<Alarm>>(
        orElse: () => [],
        permissionGranted: (alarms) => alarms,
      ),
    );
    final index = list.indexWhere((element) => element.id == event.id);
    final alarm = list.firstWhere((element) => element.id == event.id);
    final newAlarm = alarm.copyWith(on: false);
    list.removeAt(index);
    list.insert(index, newAlarm);
    emit(AlarmState.permissionGranted(list));
  }

  Future<void> _onStart(
    _AlarmStartEvent event,
    Emitter<AlarmState> emit,
  ) async {
    emit(
      AlarmState.permissionGranted(
        [
          Alarm(
            id: 1,
            time: '5:00',
            timeOfDay: 'AM',
            days: 'Sun, Wed, Sat',
            on: true,
          ),
          Alarm(
            id: 2,
            time: '7:00',
            timeOfDay: 'AM',
            days: 'Sun, Fri',
            on: false,
          ),
          Alarm(
            id: 3,
            time: '7:30',
            timeOfDay: 'AM',
            days: 'Everyday',
            on: false,
          )
        ],
      ),
    );
  }
}
