import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:alarm_clock/src/features/alarm/src/domain/notification_repository.dart';
import 'package:alarm_clock/src/features/alarm/src/services/alarm_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

const String navigationActionId = 'id_3';

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
    AlarmService.stop(notificationResponse.id!);
  }
}

const String darwinNotificationCategoryPlain = 'plainCategory';

class LocalNotificationService {
  late final FlutterLocalNotificationsPlugin _localNotifications;
  final NotificationRepository notificationRepository;

  LocalNotificationService({required this.notificationRepository});

  Future<void> initialize() async {
    _localNotifications = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    final granted = await _isAndroidPermissionGranted();
    if (granted) {
      await _initializeLocalNotification(initializationSettings);
    } else {
      if (Platform.isIOS || Platform.isMacOS) {
        await _localNotifications
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            );
        await _localNotifications
            .resolvePlatformSpecificImplementation<
                MacOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            );
      } else if (Platform.isAndroid) {
        final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
            _localNotifications.resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>();

        final bool? granted = await androidImplementation?.requestPermission();
        if (granted != null) {
          _initializeLocalNotification(initializationSettings);
        }
      }
    }
  }

  Future<void> addEverydayNotification(
    DateTime endTime,
    String title,
    String description,
    int alarmId,
  ) async {
    endTime = endTime.copyWith(second: 0);
    tzData.initializeTimeZones();
    final scheduleTime = tz.TZDateTime.fromMillisecondsSinceEpoch(
      tz.local,
      endTime.millisecondsSinceEpoch,
    );

    const androidDetail = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
    );

    const iosDetail = DarwinNotificationDetails(
      categoryIdentifier: darwinNotificationCategoryPlain,
    );

    const noticeDetail = NotificationDetails(
      iOS: iosDetail,
      android: androidDetail,
    );

    int id = Random(DateTime.now().microsecondsSinceEpoch).nextInt(1000000);

    await _scheduleDailyNotification(id, scheduleTime.hour, scheduleTime.minute,
        title, description, noticeDetail);

    debugPrint('Everyday');
    notificationRepository.save(alarmId, [id]);
  }

  Future<void> addSelectedDaysNotification(
    DateTime endTime,
    String title,
    String description,
    int alarmId,
    int numberDay,
  ) async {
    tzData.initializeTimeZones();
    final scheduleTime = tz.TZDateTime.fromMillisecondsSinceEpoch(
      tz.local,
      endTime.millisecondsSinceEpoch,
    );

    const androidDetail = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
    );

    const iosDetail = DarwinNotificationDetails(
      categoryIdentifier: darwinNotificationCategoryPlain,
    );

    const noticeDetail = NotificationDetails(
      iOS: iosDetail,
      android: androidDetail,
    );

    int id = Random(DateTime.now().microsecondsSinceEpoch).nextInt(1000000);

    await _scheduleWeeklyNotification(id, numberDay, scheduleTime.hour,
        scheduleTime.minute, title, description, noticeDetail);

    final ids = await notificationRepository.get(alarmId);
    ids.add(id);
    await notificationRepository.save(alarmId, ids);
  }

  Future<bool> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await _localNotifications
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;
      return granted;
    }
    return false;
  }

  Future<void> cancel(int alarmId) async {
    final ids = await notificationRepository.get(alarmId);
    for (int id in ids) {
      _localNotifications.cancel(id);
    }
    notificationRepository.delete(alarmId);
  }

  Future<bool?> _initializeLocalNotification(
      InitializationSettings initializationSettings) {
    return _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationStream.add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == navigationActionId) {
              selectNotificationStream.add(notificationResponse.payload);
            }
            break;
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  tz.TZDateTime _nextInstanceOfHM(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfDayHM(int day, int hour, int minute) {
    tz.TZDateTime scheduledDate = _nextInstanceOfHM(hour, minute);
    while (scheduledDate.weekday != day) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> _scheduleDailyNotification(int id, int hour, int minute,
      String title, String description, NotificationDetails details) async {
    await _localNotifications.zonedSchedule(
      id,
      title,
      description,
      _nextInstanceOfHM(hour, minute),
      details,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> _scheduleWeeklyNotification(
      int id,
      int day,
      int hour,
      int minute,
      String title,
      String description,
      NotificationDetails details) async {
    debugPrint('Weekly');
    await _localNotifications.zonedSchedule(
      id,
      title,
      description,
      _nextInstanceOfDayHM(day, hour, minute),
      details,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
    debugPrint('jopa');
  }
}
