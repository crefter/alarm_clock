import 'package:alarm_clock/src/core/colors.dart';
import 'package:alarm_clock/src/features/clock/widgets/clock_widget.dart';
import 'package:flutter/material.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({Key? key}) : super(key: key);

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.12,
        left: 31,
        right: 31,
      ),
      child: Column(
        children: [
          ClockWidget(),
          const SizedBox(height: 13),
          Align(
            alignment: Alignment.centerRight,
            child: Ink(
              width: 40,
              height: 40,
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: AppColors.mainWhite,
              ),
              child: IconButton(
                splashRadius: 20,
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: const Icon(Icons.add),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.11),
          const Text('Nepal time'),
          const SizedBox(height: 22),
          const Text('May 7 Friday'),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
