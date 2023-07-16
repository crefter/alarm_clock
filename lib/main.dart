import 'dart:async';

import 'package:alarm_clock/src/app/screens/home_screen.dart';
import 'package:alarm_clock/src/core/app_colors.dart';
import 'package:alarm_clock/src/features/alarm/src/data/alarm_repository_impl.dart';
import 'package:alarm_clock/src/features/alarm/src/data/notification_repository_impl.dart';
import 'package:alarm_clock/src/features/alarm/src/domain/notification_bloc.dart';
import 'package:alarm_clock/src/features/alarm/src/domain/alarm_bloc.dart';
import 'package:alarm_clock/src/features/alarm/src/services/alarm_service.dart';
import 'package:alarm_clock/src/features/alarm/src/services/local_notification_service.dart';
import 'package:alarm_clock/src/features/clock/src/data/clock_repository_impl.dart';
import 'package:alarm_clock/src/features/clock/src/data/month_mapper.dart';
import 'package:alarm_clock/src/features/clock/src/data/number_weekday_to_name_mapper.dart';
import 'package:alarm_clock/src/features/clock/src/data/time_api.dart';
import 'package:alarm_clock/src/features/clock/src/domain/clock_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sp = await SharedPreferences.getInstance();

  await AlarmService.init();

  LocalNotificationService notificationService = LocalNotificationService(
    notificationRepository: NotificationRepositoryImpl(sp),
  );
  await notificationService.initialize();
  NotificationBloc notificationBloc = NotificationBloc(
    notificationService: notificationService,
  );

  final clockBloc = ClockBloc(
    ClockRepositoryImpl(
      timeApi: TimeApi(
        dayMapper: NumberWeekdayToNameMapper(),
        monthMapper: MonthMapper(),
      ),
    ),
  );
  clockBloc.add(const ClockEvent.start());
  Future.delayed(Duration.zero);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: clockBloc,
        ),
        BlocProvider.value(
          value: notificationBloc,
        ),
      ],
      child: BlocProvider<AlarmBloc>(
        create: (context) =>
            AlarmBloc(repository: AlarmRepositoryImpl(pref: sp))
              ..add(const AlarmEvent.start()),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: AppColors.mainWhite,
      ),
      home: const SafeArea(child: HomeScreen()),
    );
  }
}
