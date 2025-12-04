import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workium/core/constants/app_assets.dart';
import 'package:workium/core/constants/app_colors.dart';
import 'package:workium/core/theme/app_text_styles.dart';

class PasswordValidationIndicator extends StatelessWidget {
  final String text;
  final bool isValid;

  const PasswordValidationIndicator({
    required this.text,
    required this.isValid,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String svgIcon = isValid ? AppAssets.validIcon : AppAssets.redXIcon;

    return Row(
      children: [

        SvgPicture.asset(svgIcon,width: 10.w),
        SizedBox(width: 15.w),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.caption
          ),
        ),
      ],
    );
  }
}