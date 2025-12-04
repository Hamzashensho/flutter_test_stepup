import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workium/core/theme/app_text_styles.dart';

class TermsText extends StatelessWidget {
  const TermsText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 25.w),
        child: Text.rich(
          TextSpan(
            text: 'By signing up, you agree ',
            style: AppTextStyles.footnote,
            children:  [
              TextSpan(
                text: 'Terms Of Service',
                style: TextStyle(decoration: TextDecoration.underline),
              ),
              TextSpan(text: ' And '),
              TextSpan(
                text: 'Privacy Policy',
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
