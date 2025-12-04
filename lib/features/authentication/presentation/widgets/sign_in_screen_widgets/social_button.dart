import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workium/core/constants/app_assets.dart';
import 'package:workium/core/constants/app_colors.dart';
import 'package:workium/core/theme/app_text_styles.dart';
import 'package:workium/core/widgets/custom_elevated_button.dart';

class SocialButtons extends StatelessWidget {
  final VoidCallback onEmailPressed;

  const SocialButtons({super.key, required this.onEmailPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 45.h,
          child: ElevatedButton.icon(
            onPressed: () {
              // Handle Google sign in
            },
            icon: SvgPicture.asset(
              AppAssets.googleIcon,
              height: 16.h,
              width: 16.w,
            ),
            label: Text(
              'Continue with Google',
              style: AppTextStyles.button.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.typographyPrimary,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.grayLighter,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ),
        ),
        SizedBox(height: 27.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text('Or', style: AppTextStyles.caption),
        ),
        SizedBox(height: 27.h),
        CustomElevatedButton(
          onPress: onEmailPressed,
          title: 'Continue with email',
          backgroundColor: AppColors.primaryAzure,
        ),
      ],
    );
  }
}