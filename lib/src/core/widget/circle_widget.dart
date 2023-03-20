import 'package:alarm_clock/src/core/colors.dart';
import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  final Widget child;

  const CircleWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.64,
      height: size.width * 0.64,
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
