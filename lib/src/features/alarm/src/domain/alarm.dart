class Alarm {
  final int id;
  final String time;

  //am or pm
  final String timeOfDay;
  final String days;
  final bool on;

  Alarm({
    required this.id,
    required this.time,
    required this.timeOfDay,
    required this.days,
    required this.on,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Alarm &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          timeOfDay == other.timeOfDay &&
          days == other.days &&
          on == other.on;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      timeOfDay.hashCode ^
      days.hashCode ^
      on.hashCode;

  Alarm copyWith({
    int? id,
    String? time,
    String? timeOfDay,
    String? days,
    bool? on,
  }) {
    return Alarm(
      id: id ?? this.id,
      time: time ?? this.time,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      days: days ?? this.days,
      on: on ?? this.on,
    );
  }
}
