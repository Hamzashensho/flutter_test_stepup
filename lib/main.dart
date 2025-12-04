import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workium/core/dio/dio_helper.dart';
import 'package:workium/core/router/app_router.dart';
import 'package:workium/core/router/route_paths.dart';
import 'package:workium/features/authentication/presentation/blocs/auth/auth_bloc.dart';
import 'package:workium/features/authentication/presentation/blocs/signup_bloc/sign_up_bloc.dart';
import 'package:workium/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:workium/injection_container.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await init();

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpBloc>(
          create: (context) => sl<SignUpBloc>(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>()..add(AuthCheckStatus()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, g) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: RoutePaths.splash,
            onGenerateRoute: AppRouter.generateRoute,
          );
        },
      ),
    );
  }
}

