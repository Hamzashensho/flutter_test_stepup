import 'package:flutter/material.dart';
import 'package:workium/core/constants/app_colors.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.primaryAzure,
    fontFamily: 'Rubik',

    colorScheme: ColorScheme.light(
      primary: AppColors.primaryAzure,
      secondary: AppColors.typographySecondary,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  );
}

