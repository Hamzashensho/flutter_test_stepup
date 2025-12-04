import 'package:dartz/dartz.dart';
import 'package:workium/core/error/failure.dart';
import 'package:workium/core/usecases/usecase.dart';
import 'package:workium/features/authentication/domain/entities/login_info_entity.dart';
import 'package:workium/features/authentication/domain/repositories/auth_repository.dart';

class GetLoginInfoUseCase implements UseCase<LoginInfoEntity, NoParams> {
  final AuthRepository repository;

  GetLoginInfoUseCase(this.repository);

  @override
  Future<Either<Failure, LoginInfoEntity>> call(NoParams params) async {
    return await repository.getCurrentLoginInfo();
  }
}