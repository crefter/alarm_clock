import 'package:alarm_clock/src/features/alarm/src/domain/notification_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  SharedPreferences pref;

  NotificationRepositoryImpl(this.pref);

  @override
  Future<List<int>> get(int alarmId) async {
    List<String>? str = pref.getStringList(alarmId.toString());
    if (str == null) {
      return [];
    } else {
      return str.map((e) => int.parse(e)).toList();
    }
  }

  @override
  Future<void> save(int alarmId, List<int> id) async {
    List<String> strId = id.map((e) => e.toString()).toList();
    await pref.setStringList(alarmId.toString(), strId);
  }

  @override
  Future<void> delete(int alarmId) async {
    await pref.remove(alarmId.toString());
  }
}
