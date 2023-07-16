import 'package:alarm_clock/src/features/clock/src/data/time_api.dart';
import 'package:alarm_clock/src/features/clock/src/domain/clock.dart';
import 'package:alarm_clock/src/features/clock/src/domain/clock_repository.dart';

class ClockRepositoryImpl implements ClockRepository {
  final TimeApi timeApi;

  ClockRepositoryImpl({required this.timeApi});

  @override
  Stream<Clock> getTime() async* {
    yield* Stream.periodic(
      const Duration(seconds: 1),
      (_) => timeApi.getTime(),
    ).asyncMap<Clock>(
      (event) async => (await event).toClock(),
    );
  }
}
