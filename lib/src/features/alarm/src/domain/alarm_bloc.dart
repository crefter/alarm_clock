import 'dart:math';

import 'package:alarm_clock/src/features/alarm/src/domain/alarm_repository.dart';
import 'package:alarm_clock/src/features/alarm/src/domain/alarm_type.dart';
import 'package:alarm_clock/src/features/alarm/src/domain/alarm.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'alarm_event.dart';

part 'alarm_state.dart';

part 'alarm_bloc.freezed.dart';

class AlarmBloc extends Bloc<AlarmEvent, AlarmState> {
  final AlarmRepository repository;

  AlarmBloc({required this.repository}) : super(const AlarmState.initial()) {
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

  Future<void> _onAddAlarm(_AlarmAddAlarmEvent event,
      Emitter<AlarmState> emit,) async {
    final list = List.of(
      state.maybeWhen<List<Alarm>>(
        orElse: () => [],
        permissionGranted: (alarms) => alarms,
      ),
    );
    final alarm = Alarm(type: event.type,
      id: Random(DateTime.now().millisecondsSinceEpoch).nextInt(1000000),
      time: event.time,
      timeOfDay: event.timeOfDay,
      days: event.days,
      on: event.on,);
    list.add(alarm);
    emit(AlarmState.permissionGranted(list));
    repository.save(list);
  }

  Future<void> _onDeleteAlarm(_AlarmDeleteAlarmEvent event,
      Emitter<AlarmState> emit,) async {
    final list = List.of(
      state.maybeWhen<List<Alarm>>(
        orElse: () => [],
        permissionGranted: (alarms) => alarms,
      ),
    );
    list.remove(event.alarm);
    emit(AlarmState.permissionGranted(list));
    await repository.save(list);
  }

  Future<void> _onOn(_AlarmOnEvent event,
      Emitter<AlarmState> emit,) async {
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
    await repository.save(list);
  }

  Future<void> _onOff(_AlarmOffEvent event,
      Emitter<AlarmState> emit,) async {
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
    await repository.save(list);
  }

  Future<void> _onStart(_AlarmStartEvent event,
      Emitter<AlarmState> emit,) async {
    await repository.get();
    emit(
      AlarmState.permissionGranted(
        [
          Alarm(
            type: AlarmType.selectedDays,
            id: 1,
            time: '5:00',
            timeOfDay: 'AM',
            days: 'Sun, Wed, Sat',
            on: true,
          ),
          Alarm(
            type: AlarmType.selectedDays,
            id: 2,
            time: '7:00',
            timeOfDay: 'AM',
            days: 'Sun, Fri',
            on: false,
          ),
          Alarm(
            type: AlarmType.everyday,
            id: 3,
            time: '11:48',
            timeOfDay: 'PM',
            days: 'Everyday',
            on: false,
          )
        ],
      ),
    );
  }
}
