import 'package:dartz/dartz.dart';
import 'package:workium/core/error/failure.dart';
import 'package:workium/core/usecases/usecase.dart';

import 'package:workium/features/authentication/domain/entities/password_complexity_entity.dart';
import 'package:workium/features/authentication/domain/repositories/auth_repository.dart';

class GetPasswordComplexityUseCase implements UseCase<PasswordComplexityEntity, NoParams> {
  final AuthRepository repository;

  GetPasswordComplexityUseCase(this.repository);

  @override
  Future<Either<Failure, PasswordComplexityEntity>> call(NoParams params) async {
    return await repository.getPasswordComplexity();
  }
}