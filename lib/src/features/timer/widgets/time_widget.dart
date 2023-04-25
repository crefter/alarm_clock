import 'package:alarm_clock/src/core/app_style.dart';
import 'package:alarm_clock/src/core/widgets/circle_widget.dart';
import 'package:alarm_clock/src/features/timer/src/domain/time.dart';
import 'package:alarm_clock/src/features/timer/src/domain/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimeWidget extends StatelessWidget {
  const TimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CircleWidget(
      width: size.width * 0.64,
      height: size.width * 0.64,
      child: Center(
        child: BlocBuilder<TimerBloc, TimerState>(
          builder: (context, state) {
            final Time time = state.time;
            final hours = time.hours.toString().padLeft(2, '0');
            final minutes = time.minutes.toString().padLeft(2, '0');
            final seconds = time.seconds.toString().padLeft(2, '0');
            return Text(
              '$hours:$minutes:$seconds',
              style: Theme.of(context).timeBlackStyle,
            );
          },
        ),
      ),
    );
  }
}
