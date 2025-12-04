// lib/core/widgets/custom_text_field.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workium/core/constants/app_assets.dart';
import 'package:workium/core/constants/app_colors.dart';
import 'package:workium/core/theme/app_text_styles.dart';

class CustomInputField extends StatelessWidget {
  final String title;
  final String svgPrefixIcon;
  final String hintText;
  final String? svgSuffixIcon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool obscureText;

  const CustomInputField({
    super.key,
    required this.title,
    required this.svgPrefixIcon,
    required this.hintText,
    this.svgSuffixIcon,
    this.controller,
    this.onChanged,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.sectionTitle,
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          obscureText: obscureText,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIconConstraints: BoxConstraints(
              minWidth: 16.w,
              minHeight: 16.h,
            ),
            suffixIconConstraints: BoxConstraints(
              minWidth: 16.w,
              minHeight: 16.h,
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: SvgPicture.asset(
                svgPrefixIcon,
                height: 16.h,
              ),
            ),
            suffixIcon: svgSuffixIcon != null
                ? SvgPicture.asset(
              svgSuffixIcon!,
              height: 13.h,
            )
                : null,
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.uiGrayDarker,
                width: 1.0,
              ),
            ),
          ),
          style: AppTextStyles.sectionTitle,
        ),
      ],
    );
  }
}