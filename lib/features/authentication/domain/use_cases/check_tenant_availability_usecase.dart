import 'package:dartz/dartz.dart';
import 'package:workium/core/error/failure.dart';
import 'package:workium/core/usecases/usecase.dart';
import 'package:workium/features/authentication/domain/entities/tenant_availability_entity.dart';
import 'package:workium/features/authentication/domain/repositories/auth_repository.dart';

class CheckTenantAvailabilityUseCase implements UseCase<TenantAvailabilityEntity, String> {
  final AuthRepository repository;

  CheckTenantAvailabilityUseCase(this.repository);

  @override
  Future<Either<Failure, TenantAvailabilityEntity>> call(String params) async {
    return await repository.checkTenantAvailability(params);
  }
}