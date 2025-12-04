// widgets/password_strength_meter.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workium/core/constants/app_assets.dart';
import 'package:workium/core/constants/app_colors.dart';
import 'package:workium/core/theme/app_text_styles.dart';

class PasswordStrengthMeter extends StatelessWidget {
  final double strengthRatio; // 0.0 to 1.0
  final Color strengthColor;
  final String statusText;

  const PasswordStrengthMeter({
    required this.strengthRatio,
    required this.strengthColor,
    required this.statusText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Corresponds to Rectangle 493 and Rectangle 494
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Strength Bar
        SizedBox(
          width: 343.w, // Full width based on specs
          height: 7.h,
          child: Stack(
            children: [
              // Background (Rectangle 493)
              Container(
                decoration: BoxDecoration(
                  color: AppColors.uiGrayLighter,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              // Foreground/Strength (Rectangle 494)
              FractionallySizedBox(
                widthFactor: strengthRatio,
                child: Container(
                  decoration: BoxDecoration(
                    color: strengthColor,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 9.h),
        Row(
          children: [
            SvgPicture.asset(AppAssets.warningIcon,height: 16.h,),
            SizedBox(width: 8.w),
            Text(
              statusText,
              style: AppTextStyles.sectionTitle.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}