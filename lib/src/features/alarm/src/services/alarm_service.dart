import 'dart:async';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:vibration/vibration.dart';

class AlarmService {
  static Future<void> init() async {
    await AndroidAlarmManager.initialize();
  }

  static Future<void> start(DateTime dateTime, int id) async {
    await AndroidAlarmManager.oneShotAt(
      dateTime,
      id,
      callback,
      wakeup: true,
      exact: true,
      allowWhileIdle: true,
      rescheduleOnReboot: true,
    );
  }

  static Future<void> stop(int id) async {
    await AndroidAlarmManager.cancel(id);
  }

  @pragma('vm:entry-point')
  static Future<void> callback(int id, Map<String, dynamic> data) async {
    debugPrint('Alarm played');
    final audioPlayer = AudioPlayer();
    triggerVibrations(duration: 15000);
    try {
      audioPlayer.setReleaseMode(ReleaseMode.loop);
      audioPlayer.setVolume(0.8);
      audioPlayer.play(AssetSource('alarm.mp3'));
    } catch (e) {
      await audioPlayer.dispose();
    }
    Future.delayed(
      const Duration(seconds: 15),
      () async => await audioPlayer.stop(),
    );
  }

  static Future<void> triggerVibrations({required int duration}) async {
    final hasVibrator = await Vibration.hasVibrator() ?? false;
    if (!hasVibrator) {
      debugPrint('Vibrations are not available on this device.');
      return;
    }
    Vibration.vibrate(duration: duration);
  }
}
