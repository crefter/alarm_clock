import 'dart:convert';

import 'package:alarm_clock/src/features/alarm/src/domain/alarm.dart';
import 'package:alarm_clock/src/features/alarm/src/domain/alarm_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlarmRepositoryImpl extends AlarmRepository {
  static const String _key = 'alarms';

  final SharedPreferences pref;

  AlarmRepositoryImpl({required this.pref});

  @override
  Future<List<Alarm>> get() async {
    final json = pref.getString(_key);
    if (json != null) {
      final List<dynamic> decodedJson = jsonDecode(json);
      return decodedJson.map((e) => Alarm.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<void> save(List<Alarm> alarms) async {
    String json = jsonEncode(alarms.map((e) => e.toJson()).toList()).toString();
    await pref.setString(_key, json);
  }

}