import 'package:dartz/dartz.dart';
import 'package:workium/core/error/app_exception.dart';
import 'package:workium/core/error/failure.dart';
import 'package:workium/features/authentication/data/data_sources/auth_remote_datasource.dart';
import 'package:workium/features/authentication/domain/entities/auth_entity.dart';
import 'package:workium/features/authentication/domain/entities/edition_entity.dart';
import 'package:workium/features/authentication/domain/entities/login_info_entity.dart';
import 'package:workium/features/authentication/domain/entities/password_complexity_entity.dart';
import 'package:workium/features/authentication/domain/entities/tenant_availability_entity.dart';
import 'package:workium/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, LoginInfoEntity>> getCurrentLoginInfo() async {
    try {
      final result = await remoteDataSource.getCurrentLoginInfo();
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure('Network Error'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure('Network Error'));
    } catch (e) {
      return Left(ServerFailure('Network Error'));
    }
  }

  @override
  Future<Either<Failure, List<EditionEntity>>> getEditionsForSelect() async {
    try {
      final result = await remoteDataSource.getEditionsForSelect();
      final editions = result.map((model) => model.toEntity()).toList();
      return Right(editions);
    } on ServerException catch (e) {
      return Left(ServerFailure('Network Error'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure('Network Error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PasswordComplexityEntity>> getPasswordComplexity() async {
    try {
      final result = await remoteDataSource.getPasswordComplexity();
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure('Network Error'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure('Network Error'));
    } catch (e) {
      return Left(ServerFailure('Network Error'));
    }
  }

  @override
  Future<Either<Failure, TenantAvailabilityEntity>> checkTenantAvailability(
      String tenancyName) async {
    try {
      final result = await remoteDataSource.checkTenantAvailability(tenancyName);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure('Network Error'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure('Network Error'));
    } catch (e) {
      return Left(ServerFailure('Network Error'));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> registerTenant({
    required String adminEmailAddress,
    required String adminFirstName,
    required String adminLastName,
    required String adminPassword,
    required String editionId,
    required String name,
    required String tenancyName,
    required String timeZone,
  }) async {
    try {
      final result = await remoteDataSource.registerTenant(
        adminEmailAddress: adminEmailAddress,
        adminFirstName: adminFirstName,
        adminLastName: adminLastName,
        adminPassword: adminPassword,
        editionId: editionId,
        name: name,
        tenancyName: tenancyName,
        timeZone: timeZone,
      );
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure('Network Error'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure('Network Error'));
    } catch (e) {
      return Left(ServerFailure('Network Error'));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> authenticate({
    required String userNameOrEmailAddress,
    required String password,
    required String tenancyName,
    required String timeZone,
  }) async {
    try {
      final result = await remoteDataSource.authenticate(
        userNameOrEmailAddress: userNameOrEmailAddress,
        password: password,
        tenancyName: tenancyName,
        timeZone: timeZone,
      );
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure('Network Error'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure('Network Error'));
    } catch (e) {
      return Left(ServerFailure('Network Error'));
    }
  }


}