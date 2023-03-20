import 'package:flutter/material.dart';

class ClockNumbersWidget extends StatelessWidget {
  final double radians;
  final Widget child;
  const ClockNumbersWidget({Key? key, required this.radians, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(angle: radians, child: child);
  }
}
