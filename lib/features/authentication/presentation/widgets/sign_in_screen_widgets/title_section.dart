import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workium/core/constants/app_assets.dart';
import 'package:workium/core/theme/app_text_styles.dart';

class TitleSection extends StatelessWidget {
  final String title;
  const TitleSection({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        Text(title, style: AppTextStyles.title),
        SizedBox(height: 8.h),
        Row(
          children: [
            Text("Let's start an amazing journey!",
                style: AppTextStyles.subtitle),
            SizedBox(width: 8.w),
            SvgPicture.asset(AppAssets.wavingHandIcon,width: 22.h),
          ],
        ),
      ],
    );
  }
}
