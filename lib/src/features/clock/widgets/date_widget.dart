import 'package:alarm_clock/src/core/app_style.dart';
import 'package:alarm_clock/src/features/clock/src/domain/clock_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClockBloc, ClockState>(
      builder: (context, state) {
        final date = state.maybeWhen(
          loaded: (clock) => clock.date,
          orElse: () => '',
        );
        return Text(
          date,
          style: Theme.of(context).dateStyle,
        );
      },
    );
  }
}
