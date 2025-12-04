import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workium/core/constants/app_assets.dart';
import 'package:workium/core/constants/app_colors.dart';
import 'package:workium/core/theme/app_text_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPress;
  final String title;
  final Color backgroundColor;

  const CustomElevatedButton({
    super.key,
    required this.onPress,
    required this.title, required this.backgroundColor,

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45.h,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 50.w),
            Text(title,
                style: AppTextStyles.button
                    .copyWith(color: Colors.white)),
            SizedBox(width: 20.w),
            Container(
              width: 24.w,
              height: 16.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: SvgPicture.asset(AppAssets.arrowIcon,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
