part of 'alarm_bloc.dart';

@freezed
class AlarmEvent with _$AlarmEvent {
  const factory AlarmEvent.start() = _AlarmStartEvent;

  const factory AlarmEvent.addAlarm(
    Alarm alarm,
  ) = _AlarmAddAlarmEvent;

  const factory AlarmEvent.deleteAlarm(Alarm alarm) = _AlarmDeleteAlarmEvent;

  const factory AlarmEvent.on(int id) = _AlarmOnEvent;

  const factory AlarmEvent.off(int id) = _AlarmOffEvent;
}
