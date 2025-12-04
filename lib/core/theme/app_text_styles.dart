import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workium/core/constants/app_colors.dart';

class AppTextStyles {
  static final TextStyle title = TextStyle(
    fontFamily: 'Rubik',
    fontSize: 22.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.typographyPrimary,
    letterSpacing: -0.35
  );

  static final TextStyle subtitle = TextStyle(
    fontFamily: 'Rubik',
    fontSize: 17.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.typographySecondary,
    letterSpacing: -0.408,
  );

  static final TextStyle button = TextStyle(
    fontFamily: 'Rubik',
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.32,
  );

  static final TextStyle caption = TextStyle(
    fontFamily: 'Rubik',
    fontSize: 12.sp,
    color: AppColors.typographySecondary,
    fontWeight: FontWeight.w400
  );

  static final TextStyle footnote = TextStyle(
    fontFamily: 'Rubik',
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.typographySecondary,
    letterSpacing: -0.078,
    height: 1.38,
  );

  static final TextStyle sectionTitle = TextStyle(
    fontFamily: 'Rubik',
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.sectionTitle,
    letterSpacing: -0.24,
  );
}