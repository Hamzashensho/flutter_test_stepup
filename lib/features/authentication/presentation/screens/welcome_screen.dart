import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workium/core/constants/app_assets.dart';
import 'package:workium/core/theme/app_text_styles.dart';
import 'package:workium/features/authentication/presentation/widgets/buttom_logo_and_text.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            SizedBox(height: 20.h),

            Align(
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: AppTextStyles.title,
                  children: [
                    const TextSpan(text: 'Thank you for choosing '),
                    const TextSpan(text: 'Workiom '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: SvgPicture.asset(
                        AppAssets.workiomLogo,
                        height: 30.h,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // bottom logo + extra space under it
            Padding(
              padding: EdgeInsets.only(bottom: 40.h),
              child: const ButtomLogoAndText(),
            ),
          ],
        ),
      ),
    );
  }
}
