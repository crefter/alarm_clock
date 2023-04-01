part of 'notification_bloc.dart';

@freezed
class NotificationEvent with _$NotificationEvent {
  const factory NotificationEvent.addEveryday(
    DateTime endTime,
    String title,
    String description,
    int id,
  ) = _NotificationAddEverydayEvent;

  const factory NotificationEvent.addWeekday(
      DateTime endTime,
      String title,
      String description,
      int id,
      ) = _NotificationAddWeekdayEvent;

  const factory NotificationEvent.addSelectedDays(
      Map<int, AlarmDetails> alarms,
      ) = _NotificationAddSelectedDaysEvent;

  const factory NotificationEvent.cancel(int id) = _NotificationCancelEvent;
}
