import 'package:alarm_clock/src/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension AppStyles on ThemeData {
  TextStyle get tabBarSelectedStyle => GoogleFonts.roboto(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: AppColors.selectedTabBarColor,
      );

  TextStyle get tabBarUnselectedStyle => GoogleFonts.roboto(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: AppColors.unselectedTabBarColor,
      );

  TextStyle get timeZoneStyle => GoogleFonts.roboto(
        fontWeight: FontWeight.w400,
        fontSize: 18,
        color: AppColors.timeZoneTextColor,
      );

  TextStyle get dateStyle => GoogleFonts.roboto(
        fontWeight: FontWeight.w400,
        fontSize: 18,
        color: AppColors.black,
      );

  TextStyle get timeBlackStyle => GoogleFonts.roboto(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      );

  TextStyle get timeWhiteStyle => GoogleFonts.roboto(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      );

  TextStyle get daysAlarmBlackStyle => GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      );

  TextStyle get daysAlarmWhiteStyle => GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      );

  TextStyle get AMBlackStyle => GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.blackOpacity7,
        height: 2.2,
      );

  TextStyle get AMWhiteStyle => GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.whiteOpacity7,
        height: 2.2,
      );
}
