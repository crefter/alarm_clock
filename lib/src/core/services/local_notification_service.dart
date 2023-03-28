import 'dart:async';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

// TODO: USE SERVICE IN MAIN

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
  }
}

const String darwinNotificationCategoryPlain = 'plainCategory';

class LocalNotificationService {
  late final FlutterLocalNotificationsPlugin _localNotifications;

  Future<void> initialize() async {
    _localNotifications = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

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

  Future<void> addNotification(
    DateTime endTime,
  ) async {
    tzData.initializeTimeZones();
    final scheduleTime = tz.TZDateTime.fromMillisecondsSinceEpoch(
      tz.local,
      endTime.millisecondsSinceEpoch,
    );

    const androidDetail = AndroidNotificationDetails(
        'channel_id', // channel Id
        'channel_name' // channel Name
        );

    const iosDetail = DarwinNotificationDetails(
      categoryIdentifier: darwinNotificationCategoryPlain,
    );

    const noticeDetail = NotificationDetails(
      iOS: iosDetail,
      android: androidDetail,
    );

    const id = 0;

    await _localNotifications.zonedSchedule(
      id,
      'Alarm!',
      'Alarm is started',
      scheduleTime,
      noticeDetail,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
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

  Future<void> cancelAllNotification() async {
    _localNotifications.cancelAll();
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
}
