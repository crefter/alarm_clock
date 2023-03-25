import 'dart:math';

import 'package:alarm_clock/src/core/app_colors.dart';
import 'package:alarm_clock/src/features/clock/src/domain/clock_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MinuteArrowWidget extends ArrowWidget {
  const MinuteArrowWidget({
    Key? key,
    required super.width,
    required super.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClockBloc, ClockState>(
      builder: (context, state) {
        final minutes = state.maybeWhen(
          loaded: (clock) => clock.minutes,
          orElse: () => 0,
        );
        return Transform.rotate(
          alignment:
              FractionalOffset(0.19, (minutes > 43 || minutes == 0) ? 1 : 0),
          angle: (6 * minutes - 90) * pi / 180,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.minuteArrowColor,
              borderRadius: BorderRadius.circular(45),
            ),
            width: super.width,
            height: super.height,
          ),
        );
      },
    );
  }
}

class HourArrowWidget extends ArrowWidget {
  const HourArrowWidget({
    Key? key,
    required super.width,
    required super.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClockBloc, ClockState>(
      builder: (context, state) {
        final hours = state.maybeWhen(
          loaded: (clock) => clock.hours,
          orElse: () => 0,
        );
        final minutes = state.maybeWhen(
          loaded: (clock) => clock.minutes,
          orElse: () => 0,
        );
        return Transform.rotate(
          alignment: FractionalOffset(
              0.925,
              (hours == 11 || hours == 23 || hours == 12 || hours == 0)
                  ? 1.3
                  : 0),
          angle: (30 * hours + minutes * 0.5 + 90) * pi / 180,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.hourArrowColor,
              borderRadius: BorderRadius.circular(45),
            ),
            width: super.width,
            height: super.height,
          ),
        );
      },
    );
  }
}

abstract class ArrowWidget extends StatelessWidget {
  final double width;
  final double height;

  const ArrowWidget({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);
}
