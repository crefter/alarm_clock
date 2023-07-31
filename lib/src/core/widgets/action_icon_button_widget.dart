import 'package:alarm_clock/src/core/app_colors.dart';
import 'package:flutter/material.dart';

class ActionIconButton extends StatelessWidget {
  final void Function() onPressed;
  final double size;
  final Icon icon;

  const ActionIconButton({
    Key? key,
    required this.onPressed,
    required this.size,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: size,
      height: size,
      decoration: const ShapeDecoration(
        shape: CircleBorder(),
        color: AppColors.mainWhite,
        shadows: [
          BoxShadow(
            offset: Offset(10, 10),
            blurRadius: 20,
            color: AppColors.actionIconButtonDarkShadowColor,
          ),
          BoxShadow(
            offset: Offset(-10, -10),
            blurRadius: 20,
            color: AppColors.lightShadowColor,
          ),
        ],
      ),
      child: IconButton(
        splashRadius: size / 2,
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }
}
