import 'package:flutter/material.dart';
import 'package:workium/core/router/route_paths.dart';
import 'package:workium/features/authentication/presentation/screens/register_screen.dart';
import 'package:workium/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:workium/features/authentication/presentation/screens/splash_screen.dart';
import 'package:workium/features/authentication/presentation/screens/welcome_screen.dart';
import 'package:workium/features/authentication/presentation/screens/workspace_setup_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RoutePaths.welcome:
        return MaterialPageRoute(builder: (_) =>const CreateAccountScreen());
      case RoutePaths.register:
        return MaterialPageRoute(builder: (_) =>const RegisterScreen());
      case RoutePaths.workspaceSetup:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => WorkspaceSetupScreen( email: args['email'],
          password: args['password'],));
      case RoutePaths.welcomeMessage:
        return MaterialPageRoute(builder: (_) =>const WelcomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route found')),
          ),
        );
    }
  }
}
