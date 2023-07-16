class Time {
  final int _hours;
  final int _minutes;
  final int _seconds;

  int get seconds => _seconds;

  int get minutes => _minutes;

  int get hours => _hours;

  Time(int hours, int minutes, int seconds)
      : _hours = hours,
        _minutes = minutes,
        _seconds = seconds;

  Time.origin()
      : _hours = 0,
        _minutes = 0,
        _seconds = 0;

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      json['hours'] as int,
      json['minutes'] as int,
      json['seconds'] as int,
    );
  }

  bool isNotEmpty() {
    if (_seconds != 0 || _minutes != 0 || _hours != 0) {
      return true;
    }
    return false;
  }

  bool hasSeconds() {
    return _seconds != 0 ? true : false;
  }

  bool hasMinutes() {
    return _minutes != 0 ? true : false;
  }

  bool hasHours() {
    return _hours != 0 ? true : false;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Time &&
          runtimeType == other.runtimeType &&
          _hours == other._hours &&
          _minutes == other._minutes &&
          _seconds == other._seconds;

  @override
  int get hashCode => _hours.hashCode ^ _minutes.hashCode ^ _seconds.hashCode;

  Map<String, dynamic> toJson() {
    return {
      'hours': '$_hours',
      'minutes': '$_minutes',
      'seconds': '$_seconds',
    };
  }

  Time copyWith(
    int? hours,
    int? minutes,
    int? seconds,
  ) {
    return Time(
      hours ?? _hours,
      minutes ?? _minutes,
      seconds ?? _seconds,
    );
  }
}
