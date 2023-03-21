import 'package:alarm_clock/src/core/widget/circle_widget.dart';
import 'package:alarm_clock/src/features/clock/widgets/arrow_widget.dart';
import 'package:alarm_clock/src/features/clock/widgets/circle_multi_child_layout_delegate.dart';
import 'package:alarm_clock/src/features/clock/widgets/clock_numbers_widget.dart';
import 'package:flutter/material.dart';

class ClockWidget extends StatefulWidget {
  const ClockWidget({Key? key}) : super(key: key);

  @override
  _ClockWidgetState createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  final List<LayoutId> clockItems = [];

  @override
  void initState() {
    super.initState();
    for (int i = 1; i < 13; i++) {
      double radians = (30 * i) * 3.15 / 180;
      if (i % 3 == 0) {
        clockItems.add(
          LayoutId(
            id: i,
            child: ClockNumbersWidget(
              radians: radians,
              child: Text('$i'),
            ),
          ),
        );
      } else {
        clockItems.add(
          LayoutId(
            id: i,
            child: ClockNumbersWidget(
              radians: radians,
              child: const Text('|'),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CircleWidget(
      width: size.width * 0.64,
      height: size.width * 0.64,
      child: LayoutBuilder(
        builder: (_, constraints) => Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: CustomMultiChildLayout(
                  delegate: CircleMultiChildLayoutDelegate(
                    ids: clockItems,
                    screenWidth: size.width,
                    radius: constraints.maxWidth / 2,
                  ),
                  children: clockItems,
                ),
              ),
            ),
            Positioned(
              left:
                  constraints.maxWidth * 0.225 - constraints.maxWidth * 0.0125,
              top: constraints.maxHeight * 0.47 + constraints.maxWidth * 0.0125,
              child: HourArrowWidget(
                width: constraints.maxWidth * 0.3,
                height: constraints.maxWidth * 0.0125,
              ),
            ),
            Positioned(
              right: constraints.maxWidth * 0.175,
              top: constraints.maxHeight * 0.484,
              child: MinuteArrowWidget(
                width: constraints.maxWidth * 0.395,
                height: constraints.maxHeight * 0.009,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
