import 'package:flutter/material.dart';
import 'package:zipmart/src/core/constants/app_constants.dart';
import 'package:zipmart/src/core/styles/app_colors.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    fontFamily: googleSans,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.white),
  );
}
