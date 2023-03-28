import 'package:alarm_clock/src/core/app_colors.dart';
import 'package:alarm_clock/src/core/text_styles.dart';
import 'package:alarm_clock/src/features/alarm/src/domain/alarm_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlarmItemWidget extends StatelessWidget {
  final int index;

  const AlarmItemWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    const durationTextColorAnimation = Duration(milliseconds: 100);
    return BlocBuilder<AlarmBloc, AlarmState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          permissionGranted: (alarms) {
            final alarm = alarms[index];
            return Container(
              height: 98,
              decoration: BoxDecoration(
                  color: alarm.on
                      ? AppColors.checkedTileColor
                      : AppColors.tileColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(10, 10),
                      blurRadius: 20,
                      color: AppColors.lightBlack,
                    ),
                    BoxShadow(
                      offset: Offset(-10, -10),
                      blurRadius: 20,
                      color: AppColors.lightShadowColor,
                    ),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 11, top: 21),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AnimatedDefaultTextStyle(
                              duration: durationTextColorAnimation,
                              style: alarm.on
                                  ? Theme.of(context).timeWhiteStyle
                                  : Theme.of(context).timeBlackStyle,
                              child: Text(alarm.time),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            AnimatedDefaultTextStyle(
                              style: alarm.on
                                  ? Theme.of(context).AMWhiteStyle
                                  : Theme.of(context).AMBlackStyle,
                              duration: durationTextColorAnimation,
                              child: Text(alarm.timeOfDay),
                            ),
                          ],
                        ),
                        AnimatedDefaultTextStyle(
                          style: alarm.on
                              ? Theme.of(context).daysAlarmWhiteStyle
                              : Theme.of(context).daysAlarmBlackStyle,
                          duration: durationTextColorAnimation,
                          child: Text(alarm.days),
                        ),
                      ],
                    ),
                  ),
                  Switch.adaptive(
                    value: alarm.on,
                    onChanged: (value) {
                      alarm.on
                          ? context
                              .read<AlarmBloc>()
                              .add(AlarmEvent.off(alarm.id))
                          : context
                              .read<AlarmBloc>()
                              .add(AlarmEvent.on(alarm.id));
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
