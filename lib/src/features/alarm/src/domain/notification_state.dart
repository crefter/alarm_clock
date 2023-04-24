part of 'notification_bloc.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState.initial() = _NotificationInitialState;
  const factory NotificationState.canceled() = _NotificationCanceledState;
  const factory NotificationState.added() = _NotificationAddedState;
}
