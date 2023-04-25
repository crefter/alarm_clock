import 'package:alarm_clock/src/core/widgets/action_icon_button_widget.dart';
import 'package:alarm_clock/src/features/timer/src/domain/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetIconButton extends StatelessWidget {
  const ResetIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionIconButton(
      onPressed: () {
        context.read<TimerBloc>().add(const TimerEvent.reset());
      },
      size: 56,
      icon: const Icon(Icons.replay, size: 36,),
    );
  }
}
