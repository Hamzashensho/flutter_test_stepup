import 'package:dartz/dartz.dart';
import 'package:workium/core/error/failure.dart';
import 'package:workium/core/usecases/usecase.dart';
import 'package:workium/features/authentication/domain/entities/edition_entity.dart';
import 'package:workium/features/authentication/domain/repositories/auth_repository.dart';

class GetEditionsUseCase implements UseCase<List<EditionEntity>, NoParams> {
  final AuthRepository repository;

  GetEditionsUseCase(this.repository);

  @override
  Future<Either<Failure, List<EditionEntity>>> call(NoParams params) async {
    return await repository.getEditionsForSelect();
  }
}