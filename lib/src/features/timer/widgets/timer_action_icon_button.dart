import 'package:alarm_clock/src/core/app_style.dart';
import 'package:alarm_clock/src/core/widgets/action_icon_button_widget.dart';
import 'package:alarm_clock/src/core/widgets/my_list_wheel_scroll_view.dart';
import 'package:alarm_clock/src/features/timer/src/domain/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerActionIconButton extends StatelessWidget {
  const TimerActionIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionIconButton(
      size: 40,
      icon: const Icon(Icons.add),
      onPressed: () {
        final screenSize = MediaQuery.of(context).size;
        showModalBottomSheet(
          constraints: BoxConstraints(
            maxHeight: screenSize.height / 2.5,
            minWidth: screenSize.width,
          ),
          context: context,
          builder: (_) {
            return BlocProvider.value(
              value: context.read<TimerBloc>(),
              child: const TimePicker(),
            );
          },
        );
      },
    );
  }
}

class TimePicker extends StatefulWidget {
  const TimePicker({Key? key}) : super(key: key);

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  late final FixedExtentScrollController _hourController;
  late final FixedExtentScrollController _minuteController;
  late final FixedExtentScrollController _secondController;

  @override
  void initState() {
    super.initState();
    _hourController = FixedExtentScrollController();
    _minuteController = FixedExtentScrollController();
    _secondController = FixedExtentScrollController();
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Text('Pick time', style: Theme.of(context).dateStyle),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('HH', style: Theme.of(context).dateStyle),
            SizedBox(width: size.width * 0.08),
            Text('MM', style: Theme.of(context).dateStyle),
            SizedBox(width: size.width * 0.08),
            Text('SS', style: Theme.of(context).dateStyle),
            SizedBox(width: size.width * 0.008),
          ],
        ),
        //const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 80,
              child: MyListWheelScrollView(
                controller: _hourController,
                countItems: 24,
              ),
            ),
            SizedBox(
              width: 60,
              height: 80,
              child: MyListWheelScrollView(
                controller: _minuteController,
                countItems: 60,
              ),
            ),
            SizedBox(
              width: 60,
              height: 80,
              child: MyListWheelScrollView(
                controller: _secondController,
                countItems: 60,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            final int hours = _hourController.selectedItem;
            final int minutes = _minuteController.selectedItem;
            final int seconds = _secondController.selectedItem;
            context.read<TimerBloc>().add(
                  TimerEvent.set(
                    hours,
                    minutes,
                    seconds,
                  ),
                );
            Navigator.pop(context);
          },
          child: const Text('Set'),
        ),
      ],
    );
  }
}
