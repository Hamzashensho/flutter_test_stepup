import 'package:dartz/dartz.dart';
import 'package:workium/core/error/failure.dart';
import 'package:workium/core/usecases/usecase.dart';
import 'package:workium/features/authentication/domain/entities/auth_entity.dart';
import 'package:workium/features/authentication/domain/repositories/auth_repository.dart';

class AuthenticateParams {
  final String userNameOrEmailAddress;
  final String password;
  final String tenancyName;
  final String timeZone;

  AuthenticateParams({
    required this.userNameOrEmailAddress,
    required this.password,
    required this.tenancyName,
    required this.timeZone,
  });
}

class AuthenticateUseCase implements UseCase<AuthEntity, AuthenticateParams> {
  final AuthRepository repository;

  AuthenticateUseCase(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(AuthenticateParams params) async {
    return await repository.authenticate(
      userNameOrEmailAddress: params.userNameOrEmailAddress,
      password: params.password,
      tenancyName: params.tenancyName,
      timeZone: params.timeZone,
    );
  }
}