import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workium/core/constants/app_assets.dart';
import 'package:workium/core/theme/app_text_styles.dart';
import 'package:workium/features/authentication/presentation/widgets/buttom_logo_and_text.dart';

class LanguageLogoSection extends StatelessWidget {
  const LanguageLogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            SvgPicture.asset(AppAssets.languageIcon,height: 16.h,),
            SizedBox(width: 8.w),
            Text('English', style: AppTextStyles.caption),
            SizedBox(width: 8.w),
            SvgPicture.asset(AppAssets.arrowDropDownIcon,width: 6.w,),
          ],
        ),

         SizedBox(height: 16.h),

        ButtomLogoAndText(),
      ],
    );
  }
}

