// lib/features/authentication/presentation/pages/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workium/core/constants/app_assets.dart';
import 'package:workium/core/router/route_paths.dart';
import 'package:workium/features/authentication/domain/entities/login_info_entity.dart';
import 'package:workium/features/authentication/presentation/blocs/signup_bloc/sign_up_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SignUpBloc>().add(GetCurrentLoginInfoEvent());
    });

    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is LoginInfoLoaded) {
          _handleLoginInfo(context, state.loginInfo);
        } else if (state is SignUpError) {
          Navigator.pushReplacementNamed(context, RoutePaths.welcome);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SvgPicture.asset(
            AppAssets.workiomLogo, // Add your logo asset
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }

  void _handleLoginInfo(BuildContext context, LoginInfoEntity loginInfo) {


    if (loginInfo.user == null) {
      // User not logged in
      Navigator.pushReplacementNamed(context, RoutePaths.welcome);
    } else if (loginInfo.tenant == null) {
      // User logged in but no tenant selected
      Navigator.pushReplacementNamed(context, RoutePaths.workspaceSetup);
    } else {
      // User logged in and tenant selected
      Navigator.pushReplacementNamed(context, RoutePaths.welcomeMessage);
    }
  }
}