import 'package:alarm_clock/src/app/screens/alarm_screen.dart';
import 'package:alarm_clock/src/app/screens/clock_screen.dart';
import 'package:alarm_clock/src/app/screens/timer_screen.dart';
import 'package:alarm_clock/src/core/app_colors.dart';
import 'package:alarm_clock/src/core/app_style.dart';
import 'package:alarm_clock/src/core/widgets/custom_tab_bar_indicator.dart';
import 'package:alarm_clock/src/features/timer/src/domain/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final size = MediaQuery
        .of(context)
        .size;
    final themeData = Theme.of(context);
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
                      color: AppColors.topTabShadowColor,
                      offset: Offset(-10, -10),
                      blurRadius: 20,
                    ),
                    BoxShadow(
                      color: AppColors.bottomTabShadowColor,
                      offset: Offset(10, 10),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Container(
                  width: 0.9 * size.width,
                  height: 45,
                  decoration: BoxDecoration(
                      color: AppColors.mainWhite,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TabBar(
                    indicator: InsetShadowBoxDecoration(
                      boxShadow: const [
                        CustomBoxShadow(
                          color: AppColors.outerShadowIndicatorColor,
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        ),
                        CustomBoxShadow(
                          color: AppColors.innerShadowIndicatorColor,
                          offset: Offset(0, 5),
                          blurRadius: 4,
                          inset: true,
                        ),
                      ],
                      color: AppColors.mainWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelColor: themeData.tabBarSelectedStyle.color,
                    unselectedLabelColor: themeData.tabBarUnselectedStyle.color,
                    labelStyle: themeData.tabBarSelectedStyle,
                    unselectedLabelStyle: themeData.tabBarUnselectedStyle,
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
              Expanded(
                child: TabBarView(
                  children: [
                    const ClockScreen(),
                    const AlarmScreen(),
                    BlocProvider(
                      create: (context) => TimerBloc(),
                      child: const TimerScreen(),
                    ),
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
