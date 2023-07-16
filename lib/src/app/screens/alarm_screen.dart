import 'package:alarm_clock/src/features/alarm/widgets/alarm_action_icon_button.dart';
import 'package:alarm_clock/src/features/alarm/widgets/alarms_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {

  @override
  void initState() {
    super.initState();
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: size.height * 0.025,
          ),
        ),
        const AlarmsListWidget(),
        SliverToBoxAdapter(
          child: SizedBox(
            height: size.height * 0.046,
          ),
        ),
        const SliverToBoxAdapter(
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(
                right: 17,
              ),
              child: AlarmActionIconButton(),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 48,
          ),
        )
      ],
    );
  }
}
