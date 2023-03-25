import 'package:alarm_clock/src/features/alarm/widgets/alarm_item_widget.dart';
import 'package:flutter/material.dart';

class AlarmsListWidget extends StatelessWidget {
  const AlarmsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 33,
              right: 17,
              left: 17,
            ),
            child: AlarmItemWidget(index: index),
          );
        },
        childCount: 3,
      ),
    );
  }
}
