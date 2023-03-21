import 'package:alarm_clock/src/core/colors.dart';
import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;

  const CircleWidget({
    Key? key,
    required this.child,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.mainWhite,
          borderRadius: BorderRadius.circular(500),
          boxShadow: const [
            BoxShadow(
              color: AppColors.black,
              offset: Offset(10, 10),
              blurRadius: 20,
            ),
            BoxShadow(
              color: AppColors.white,
              offset: Offset(-10, -10),
              blurRadius: 20,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
