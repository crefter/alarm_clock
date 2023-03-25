import 'package:alarm_clock/src/core/app_colors.dart';
import 'package:flutter/material.dart';

class AlarmItemWidget extends StatefulWidget {
  final int index;

  const AlarmItemWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<AlarmItemWidget> createState() => _AlarmItemWidgetState();
}

class _AlarmItemWidgetState extends State<AlarmItemWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.12,
      decoration: BoxDecoration(
          color: isChecked ? AppColors.checkedTileColor : AppColors.tileColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              offset: Offset(10, 10),
              blurRadius: 20,
              color: AppColors.lightBlack,
            ),
            BoxShadow(
              offset: Offset(-10, -10),
              blurRadius: 20,
              color: AppColors.lightShadowColor,
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 11, top: 21),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text('5:00'),
                    Text('AM'),
                  ],
                ),
                const Text('Sun, Wed, Sat'),
              ],
            ),
          ),
          Switch.adaptive(
            value: isChecked,
            onChanged: (value) {
              isChecked = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
