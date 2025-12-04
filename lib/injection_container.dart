import 'package:get_it/get_it.dart';
import 'package:workium/core/dio/dio_helper.dart';
import 'package:workium/core/router/app_router.dart';
import 'package:workium/features/authentication/data/data_sources/auth_remote_datasource.dart';
import 'package:workium/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:workium/features/authentication/domain/repositories/auth_repository.dart';
import 'package:workium/features/authentication/domain/use_cases/authentication_usecase.dart';
import 'package:workium/features/authentication/domain/use_cases/check_tenant_availability_usecase.dart';
import 'package:workium/features/authentication/domain/use_cases/get_edition_usecase.dart';
import 'package:workium/features/authentication/domain/use_cases/get_login_info_usecase.dart';
import 'package:workium/features/authentication/domain/use_cases/get_password_complexity_usecase.dart';
import 'package:workium/features/authentication/domain/use_cases/register_tenant_usecase.dart';
import 'package:workium/features/authentication/presentation/blocs/auth/auth_bloc.dart';
import 'package:workium/features/authentication/presentation/blocs/signup_bloc/sign_up_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Initialize Dio
  sl.registerLazySingleton(() => DioHelper());

  // Initialize App Router
  sl.registerLazySingleton(() => AppRouter());

  // BLoCs
  sl.registerFactory(() => SignUpBloc(
    getEditionsUseCase: sl(),
    getPasswordComplexityUseCase: sl(),
    checkTenantAvailabilityUseCase: sl(),
    registerTenantUseCase: sl(),
    authenticateUseCase: sl(),
    getCurrentLoginInfoUseCase: sl(),
  ));

  sl.registerFactory(() => AuthBloc());

  // Use Cases
  sl.registerLazySingleton(() => GetEditionsUseCase(sl()));
  sl.registerLazySingleton(() => GetPasswordComplexityUseCase(sl()));
  sl.registerLazySingleton(() => CheckTenantAvailabilityUseCase(sl()));
  sl.registerLazySingleton(() => RegisterTenantUseCase(sl()));
  sl.registerLazySingleton(() => AuthenticateUseCase(sl()));
  sl.registerLazySingleton(() => GetLoginInfoUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(),
  );
}