import 'package:alarm_clock/src/app/screens/alarm_screen.dart';
import 'package:alarm_clock/src/app/screens/clock_screen.dart';
import 'package:alarm_clock/src/app/screens/timer_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Column(
            children: [
              DecoratedBox(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(255, 255, 255, 0.67),
                      offset: Offset(-10, -10),
                      blurRadius: 20,
                    ),
                    BoxShadow(
                      color: Color.fromRGBO(164, 164, 164, 0.25),
                      offset: Offset(10, 10),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Container(
                  width: 0.9 * size.width,
                  height: 45,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 240, 245, 248),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TabBar(
                    //TODO: inherited from Decoration and create CustomPainter for custom indicator
                    indicator: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                        blurStyle: BlurStyle.normal),
                      ],
                      color: const Color.fromARGB(255, 240, 245, 248),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelColor: Colors.black,
                    unselectedLabelColor: const Color.fromARGB(
                      255,
                      133,
                      133,
                      133,
                    ),
                    tabs: const [
                      Tab(
                        text: 'World clock',
                      ),
                      Tab(
                        text: 'Alarm',
                      ),
                      Tab(
                        text: 'Timer',
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    ClockScreen(),
                    AlarmScreen(),
                    TimerScreen(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
