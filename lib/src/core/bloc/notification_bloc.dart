import 'package:alarm_clock/src/core/models/alarm_details.dart';
import 'package:alarm_clock/src/core/services/local_notification_service.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_event.dart';

part 'notification_state.dart';

part 'notification_bloc.freezed.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final LocalNotificationService notificationService;

  NotificationBloc({required this.notificationService})
      : super(const NotificationState.initial()) {
    on<NotificationEvent>((event, emit) async {
      await event.map(
        addEveryday: (event) => _onAddEveryday(event, emit),
        cancel: (event) => _onCancel(event, emit),
        addWeekday: (event) => _onAddWeekDay(event, emit),
        addSelectedDays: (event) => _onAddSelectedDays(event, emit),
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

  Future<void> _onAddWeekDay(
    _NotificationAddWeekdayEvent event,
    Emitter<NotificationState> emit,
  ) async {}

  Future<void> _onAddSelectedDays(
    _NotificationAddSelectedDaysEvent event,
    Emitter<NotificationState> emit,
  ) async {}
}
