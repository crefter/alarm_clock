import 'package:alarm_clock/src/app/screens/home_screen.dart';
import 'package:alarm_clock/src/core/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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