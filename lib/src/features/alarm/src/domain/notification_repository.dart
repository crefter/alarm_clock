abstract class NotificationRepository {
  Future<void> save(int alarmId, List<int> id);
  Future<List<int>> get(int alarmId);
  Future<void> delete(int alarmId);
}