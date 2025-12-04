import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:workium/core/constants/app_assets.dart';
import 'package:workium/core/constants/app_colors.dart';

class ButtomLogoAndText extends StatelessWidget {
  const ButtomLogoAndText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Stay organized with',
          style: TextStyle(fontSize: 15.sp,color: AppColors.typographySecondary),
        ),
        const SizedBox(width: 8),
        SvgPicture.asset(AppAssets.logoIcon, height: 30.h),
      ],
    );
  }
}
