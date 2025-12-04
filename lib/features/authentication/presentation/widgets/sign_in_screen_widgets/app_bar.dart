import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workium/core/constants/app_assets.dart';
import 'package:workium/core/constants/app_colors.dart';

class BackBar extends StatelessWidget {
  final String appBarTitle;
  const BackBar({super.key,required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: 4.0.h),
      child: SizedBox(
        height: 42.h,
        child: Row(
          children:  [
            Padding(
              padding: EdgeInsets.only(left: 14.w),
              child: Row(
                children: [
                  SvgPicture.asset(AppAssets.backIcon,height: 24.h),
                  SizedBox(width: 5.w),
                  appBarTitle.isNotEmpty?Text(
                    appBarTitle,
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: AppColors.primaryAzure,
                      letterSpacing: -0.408,
                    ),
                  ):SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
