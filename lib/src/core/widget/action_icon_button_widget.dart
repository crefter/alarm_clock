import 'package:alarm_clock/src/core/app_colors.dart';
import 'package:flutter/material.dart';

class ActionIconButton extends StatelessWidget {
  final void Function() onPressed;

  const ActionIconButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: 40,
      height: 40,
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
        splashRadius: 20,
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: const Icon(Icons.add),
      ),
    );
  }
}
