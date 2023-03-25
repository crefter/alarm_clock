import 'package:alarm_clock/src/core/text_styles.dart';
import 'package:alarm_clock/src/features/clock/src/domain/clock_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimeZoneWidget extends StatelessWidget {
  const TimeZoneWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClockBloc, ClockState>(
      builder: (context, state) {
        final timeZone = state.maybeWhen(
          loaded: (clock) => clock.timeZone,
          orElse: () => '',
        );
        return Text(
          timeZone,
          style: Theme.of(context).timeZoneStyle,
        );
      },
    );
  }
}
