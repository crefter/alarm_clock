import 'package:alarm_clock/src/core/app_style.dart';
import 'package:flutter/material.dart';

class MyListWheelScrollView extends StatelessWidget {
  const MyListWheelScrollView({super.key,
    required FixedExtentScrollController controller,
    required this.countItems,
  }) : _controller = controller;

  final FixedExtentScrollController _controller;
  final int countItems;

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView(
      controller: _controller,
      useMagnifier: true,
      magnification: 1.2,
      diameterRatio: 2,
      itemExtent: 30,
      children: List.generate(
        countItems,
            (index) => Text(
          index < 10 ? '0$index' : '$index',
          style: Theme.of(context).dateStyle,
        ),
      ),
    );
  }
}
