import 'dart:convert';

import 'package:alarm_clock/src/features/timer/src/domain/time.dart';
import 'package:alarm_clock/src/features/timer/src/domain/timer_repository.dart';
import 'package:alarm_clock/src/features/timer/src/exception/timer_null_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimerRepositoryImpl extends TimerRepository {
  final String _key = 'Timer';
  final SharedPreferences sp;

  TimerRepositoryImpl(this.sp);

  @override
  Future<Time> get() async {
    String? json = sp.getString(_key);
    if (json == null) {
      throw TimerNullException();
    }
    final jsonMap = jsonDecode(json);
    final Time time = Time.fromJson(jsonMap);
    return time;
  }

  @override
  Future<void> save(Time time) async {
    final json = time.toJson();
    final String jsonString = jsonEncode(json);
    await sp.setString(_key, jsonString);
  }
}
