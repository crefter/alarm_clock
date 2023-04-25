class Time {
  final int hours;
  final int minutes;
  final int seconds;

  Time(this.hours, this.minutes, this.seconds);

  Time.origin()
      : hours = 0,
        minutes = 0,
        seconds = 0;

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      json['hours'] as int,
      json['minutes'] as int,
      json['seconds'] as int,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Time &&
          runtimeType == other.runtimeType &&
          hours == other.hours &&
          minutes == other.minutes &&
          seconds == other.seconds;

  @override
  int get hashCode => hours.hashCode ^ minutes.hashCode ^ seconds.hashCode;

  Map<String, dynamic> toJson() {
    return {
      'hours': '$hours',
      'minutes': '$minutes',
      'seconds': '$seconds',
    };
  }

  Time copyWith(
    int? hours,
    int? minutes,
    int? seconds,
  ) {
    return Time(
      hours ?? this.hours,
      minutes ?? this.minutes,
      seconds ?? this.seconds,
    );
  }
}
