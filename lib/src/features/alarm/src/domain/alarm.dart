import 'package:alarm_clock/src/features/alarm/src/domain/alarm_type.dart';

class Alarm {
  final int id;
  final String time;
  final AlarmType type;

  //am or pm
  final String timeOfDay;
  final String days;
  final bool on;

  Alarm({
    required this.type,
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

  factory Alarm.fromJson(Map<String, dynamic> json) {
    return Alarm(
      type: AlarmType.values[json['type']],
      id: int.parse(json['id']),
      time: json['time'],
      timeOfDay: json['timeOfDay'],
      days: json['days'],
      on: json['on'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':'$id',
      'time':time,
      'type':type.index,
      'timeOfDay':timeOfDay,
      'days':days,
      'on':on,
    };
  }

  Alarm copyWith({
    int? id,
    AlarmType? type,
    String? time,
    String? timeOfDay,
    String? days,
    bool? on,
  }) {
    return Alarm(
      type: type ?? this.type,
      id: id ?? this.id,
      time: time ?? this.time,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      days: days ?? this.days,
      on: on ?? this.on,
    );
  }
}
