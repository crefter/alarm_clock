part of 'alarm_bloc.dart';

@freezed
class AlarmState with _$AlarmState {
  const factory AlarmState.initial() = AlarmInitialState;

  const factory AlarmState.permissionGranted(List<Alarm> alarms) =
      AlarmPermissionGrantedState;

  const factory AlarmState.permissionNotGranted() =
      AlarmPermissionNotGrantedState;
}
