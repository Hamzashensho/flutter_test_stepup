import 'package:dartz/dartz.dart';
import 'package:workium/core/error/failure.dart';
import 'package:workium/features/authentication/domain/entities/auth_entity.dart';
import 'package:workium/features/authentication/domain/entities/edition_entity.dart';
import 'package:workium/features/authentication/domain/entities/login_info_entity.dart';
import 'package:workium/features/authentication/domain/entities/password_complexity_entity.dart';
import 'package:workium/features/authentication/domain/entities/tenant_availability_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginInfoEntity>> getCurrentLoginInfo();
  Future<Either<Failure, List<EditionEntity>>> getEditionsForSelect();
  Future<Either<Failure, PasswordComplexityEntity>> getPasswordComplexity();
  Future<Either<Failure, TenantAvailabilityEntity>> checkTenantAvailability(String tenancyName);
  Future<Either<Failure, AuthEntity>> registerTenant({
    required String adminEmailAddress,
    required String adminFirstName,
    required String adminLastName,
    required String adminPassword,
    required String editionId,
    required String name,
    required String tenancyName,
    required String timeZone,
  });
  Future<Either<Failure, AuthEntity>> authenticate({
    required String userNameOrEmailAddress,
    required String password,
    required String tenancyName,
    required String timeZone,
  });
}