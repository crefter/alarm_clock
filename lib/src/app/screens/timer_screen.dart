import 'package:alarm_clock/src/features/timer/src/domain/timer_bloc.dart';
import 'package:alarm_clock/src/features/timer/widgets/pause_icon_button.dart';
import 'package:alarm_clock/src/features/timer/widgets/reset_icon_button.dart';
import 'package:alarm_clock/src/features/timer/widgets/start_icon_button.dart';
import 'package:alarm_clock/src/features/timer/widgets/time_widget.dart';
import 'package:alarm_clock/src/features/timer/widgets/timer_action_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height * 0.154),
        const TimeWidget(),
        SizedBox(height: size.height * 0.016),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const TimerActionIconButton(),
            SizedBox(
              width: size.width * 0.099,
            )
          ],
        ),
        SizedBox(height: size.height * 0.127),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<TimerBloc, TimerState>(builder: (_, state) {
              return state.maybeWhen(
                orElse: () => const StartIconButton(),
                ticking: (_) => const PauseIconButton(),
                started: (_) => const PauseIconButton(),
              );
            }),
            SizedBox(width: size.width * 0.101),
            const ResetIconButton(),
          ],
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
