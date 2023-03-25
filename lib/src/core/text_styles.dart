import 'package:alarm_clock/src/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension AppTextStyle on ThemeData {
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
    color: AppColors.dateTextColor,
  );
}
