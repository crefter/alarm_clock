import 'package:alarm_clock/src/core/widgets/action_icon_button_widget.dart';
import 'package:alarm_clock/src/features/alarm/widgets/alarms_list_widget.dart';
import 'package:flutter/material.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: size.height * 0.025,
          ),
        ),
        const AlarmsListWidget(),
        SliverToBoxAdapter(
          child: SizedBox(
            height: size.height * 0.046,
          ),
        ),
        SliverToBoxAdapter(
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 17,
              ),
              child: ActionIconButton(
                onPressed: () {},
              ),
            ),
          ),
        ),
      ],
    );
  }
}
