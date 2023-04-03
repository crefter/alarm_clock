import 'package:alarm_clock/src/features/alarm/src/domain/alarm.dart';
import 'package:alarm_clock/src/features/alarm/src/domain/alarm_details.dart';
import 'package:alarm_clock/src/features/alarm/src/domain/alarm_type.dart';
import 'package:alarm_clock/src/features/alarm/src/services/local_notification_service.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_event.dart';

part 'notification_state.dart';

part 'notification_bloc.freezed.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final LocalNotificationService notificationService;

  NotificationBloc({
    required this.notificationService,
  }) : super(const NotificationState.initial()) {
    on<NotificationEvent>((event, emit) async {
      await event.map(
        addEveryday: (event) => _onAddEveryday(event, emit),
        cancel: (event) => _onCancel(event, emit),
        addSelectedDays: (event) => _onAddSelectedDays(event, emit),
        add: (event) => _onAdd(event),
      );
    });
  }

  Future<void> _onAddEveryday(
    _NotificationAddEverydayEvent event,
    Emitter<NotificationState> emit,
  ) async {
    await notificationService.addEverydayNotification(
      event.endTime,
      event.title,
      event.description,
      event.id,
    );
  }

  Future<void> _onCancel(
    _NotificationCancelEvent event,
    Emitter<NotificationState> emit,
  ) async {
    await notificationService.cancel(event.id);
  }

  Future<void> _onAddSelectedDays(
    _NotificationAddSelectedDaysEvent event,
    Emitter<NotificationState> emit,
  ) async {
    for (final detail in event.details) {
      await notificationService.addSelectedDaysNotification(detail.endTime,
          detail.title, detail.description, event.id, detail.numberDay);
    }
  }

  Future<void> _onAdd(_NotificationAddEvent event) async {
    Alarm alarm = event.alarm;
    List<String> strTime = alarm.time.split(':');
    int hour = int.parse(strTime[0]);
    int minute = int.parse(strTime[1]);
    if (alarm.timeOfDay == "AM") {
      hour += 12;
    }
    switch (alarm.type) {
      case AlarmType.everyday:
        DateTime time = DateTime.now().copyWith(hour: hour, minute: minute);
        add(
          NotificationEvent.addEveryday(
            time,
            alarm.time,
            '${alarm.time} ${alarm.timeOfDay} Everyday',
            alarm.id,
          ),
        );
        break;
      case AlarmType.selectedDays:
        final List<AlarmDetails> details = [];
        final List<String> days = alarm.days.split(', ');
        for (final day in days) {
          int numberDay = 0;
          switch (day.toLowerCase()) {
            case 'mon':
              numberDay = 1;
              break;
            case 'tue':
              numberDay = 2;
              break;
            case 'wed':
              numberDay = 3;
              break;
            case 'thu':
              numberDay = 4;
              break;
            case 'fri':
              numberDay = 5;
              break;
            case 'sat':
              numberDay = 6;
              break;
            case 'sun':
              numberDay = 7;
              break;
          }
          DateTime time = _nextInstanceOfDayHM(numberDay, hour, minute);
          details.add(
            AlarmDetails(
              title: alarm.time,
              description: '${alarm.time} ${alarm.timeOfDay} $day',
              endTime: time,
              numberDay: numberDay,
            ),
          );
        }
        add(
          NotificationEvent.addSelectedDays(
            alarm.id,
            details,
          ),
        );
        break;
    }
  }

  DateTime _nextInstanceOfHM(int hour, int minute) {
    final DateTime now = DateTime.now();
    DateTime scheduledDate =
        DateTime(now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  DateTime _nextInstanceOfDayHM(int day, int hour, int minute) {
    DateTime scheduledDate = _nextInstanceOfHM(hour, minute);
    while (scheduledDate.weekday != day) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
