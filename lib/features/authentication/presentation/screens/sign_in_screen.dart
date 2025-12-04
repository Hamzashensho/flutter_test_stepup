// lib/features/authentication/presentation/pages/create_account_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workium/core/router/route_paths.dart';
import 'package:workium/features/authentication/presentation/widgets/sign_in_screen_widgets/app_bar.dart';
import 'package:workium/features/authentication/presentation/widgets/sign_in_screen_widgets/language_section.dart';
import 'package:workium/features/authentication/presentation/widgets/sign_in_screen_widgets/social_button.dart';
import 'package:workium/features/authentication/presentation/widgets/sign_in_screen_widgets/terms_text.dart';
import 'package:workium/features/authentication/presentation/widgets/sign_in_screen_widgets/title_section.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const BackBar(appBarTitle: 'Sign in'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 16.h),
                      const TitleSection(title: 'Create your free account'),
                      SizedBox(height: 90.h),
                      SocialButtons(onEmailPressed: () {
                        Navigator.pushNamed(context, RoutePaths.register);
                      }),
                      SizedBox(height: 16.h),
                      const TermsText(),
                      SizedBox(height: 117.h),
                      const LanguageLogoSection(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}