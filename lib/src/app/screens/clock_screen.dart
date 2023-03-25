import 'package:alarm_clock/src/features/clock/widgets/clock_widget.dart';
import 'package:alarm_clock/src/features/clock/widgets/date_widget.dart';
import 'package:alarm_clock/src/features/clock/widgets/time_zone_widget.dart';
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
          const ClockWidget(),
          SizedBox(height: size.height * 0.12),
          const TimeZoneWidget(),
          const SizedBox(height: 22),
          const DateWidget(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
