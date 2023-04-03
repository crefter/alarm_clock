part of 'notification_bloc.dart';

@freezed
class NotificationEvent with _$NotificationEvent {
  const factory NotificationEvent.addEveryday(
    DateTime endTime,
    String title,
    String description,
    int id,
  ) = _NotificationAddEverydayEvent;

  const factory NotificationEvent.addSelectedDays(
    int id,
    List<AlarmDetails> details,
  ) = _NotificationAddSelectedDaysEvent;

  const factory NotificationEvent.add(Alarm alarm) = _NotificationAddEvent;

  const factory NotificationEvent.cancel(int id) = _NotificationCancelEvent;
}
