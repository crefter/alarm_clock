import 'package:alarm_clock/src/app/screens/home_screen.dart';
import 'package:alarm_clock/src/core/app_colors.dart';
import 'package:alarm_clock/src/features/clock/src/data/clock_repository_impl.dart';
import 'package:alarm_clock/src/features/clock/src/data/month_mapper.dart';
import 'package:alarm_clock/src/features/clock/src/data/number_weekday_to_name_mapper.dart';
import 'package:alarm_clock/src/features/clock/src/data/time_api.dart';
import 'package:alarm_clock/src/features/clock/src/domain/clock_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
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
    BlocProvider.value(
      value: clockBloc,
      child: const MyApp(),
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
