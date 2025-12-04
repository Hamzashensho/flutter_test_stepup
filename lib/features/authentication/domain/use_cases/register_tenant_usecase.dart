import 'package:dartz/dartz.dart';
import 'package:workium/core/error/failure.dart';
import 'package:workium/core/usecases/usecase.dart';
import 'package:workium/features/authentication/domain/entities/auth_entity.dart';
import 'package:workium/features/authentication/domain/repositories/auth_repository.dart';

class RegisterTenantParams {
  final String adminEmailAddress;
  final String adminFirstName;
  final String adminLastName;
  final String adminPassword;
  final String editionId;
  final String name;
  final String tenancyName;
  final String timeZone;

  RegisterTenantParams({
    required this.adminEmailAddress,
    required this.adminFirstName,
    required this.adminLastName,
    required this.adminPassword,
    required this.editionId,
    required this.name,
    required this.tenancyName,
    required this.timeZone,
  });
}

class RegisterTenantUseCase implements UseCase<AuthEntity, RegisterTenantParams> {
  final AuthRepository repository;

  RegisterTenantUseCase(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(RegisterTenantParams params) async {
    return await repository.registerTenant(
      adminEmailAddress: params.adminEmailAddress,
      adminFirstName: params.adminFirstName,
      adminLastName: params.adminLastName,
      adminPassword: params.adminPassword,
      editionId: params.editionId,
      name: params.name,
      tenancyName: params.tenancyName,
      timeZone: params.timeZone,
    );
  }
}