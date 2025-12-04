// lib/features/authentication/domain/entities/login_info_entity.dart
import 'package:equatable/equatable.dart';

class LoginInfoEntity extends Equatable {
  final UserEntity? user;
  final TenantEntity? tenant;
  final ApplicationEntity? application;

  const LoginInfoEntity({
    this.user,
    this.tenant,
    this.application,
  });

  bool get isLoggedIn => user != null;
  bool get isTenantSelected => tenant != null;

  @override
  List<Object?> get props => [user, tenant, application];
}

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String surname;
  final String userName;
  final String emailAddress;
  final String? phoneNumber;
  final bool isEmailConfirmed;
  final List<String> roles;
  final String? profilePictureId;
  final bool shouldChangePasswordOnNextLogin;
  final String fullName;
  final String? profilePictureUrl;

  const UserEntity({
    required this.id,
    required this.name,
    required this.surname,
    required this.userName,
    required this.emailAddress,
    this.phoneNumber,
    required this.isEmailConfirmed,
    required this.roles,
    this.profilePictureId,
    required this.shouldChangePasswordOnNextLogin,
    required this.fullName,
    this.profilePictureUrl,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    surname,
    userName,
    emailAddress,
    phoneNumber,
    isEmailConfirmed,
    roles,
    profilePictureId,
    shouldChangePasswordOnNextLogin,
    fullName,
    profilePictureUrl,
  ];
}

class TenantEntity extends Equatable {
  final String id;
  final String tenancyName;
  final String name;
  final String? editionDisplayName;
  final bool isInTrialPeriod;
  final DateTime? subscriptionEndDateUtc;
  final bool isSubscriptionExpired;
  final DateTime? creationTime;

  const TenantEntity({
    required this.id,
    required this.tenancyName,
    required this.name,
    this.editionDisplayName,
    required this.isInTrialPeriod,
    this.subscriptionEndDateUtc,
    required this.isSubscriptionExpired,
    this.creationTime,
  });

  @override
  List<Object?> get props => [
    id,
    tenancyName,
    name,
    editionDisplayName,
    isInTrialPeriod,
    subscriptionEndDateUtc,
    isSubscriptionExpired,
    creationTime,
  ];
}

class ApplicationEntity extends Equatable {
  final String version;
  final DateTime? releaseDate;
  final CurrencyEntity? currency;

  const ApplicationEntity({
    required this.version,
    this.releaseDate,
    this.currency,
  });

  @override
  List<Object?> get props => [version, releaseDate, currency];
}

class FeatureEntity extends Equatable {
  final String name;
  final String value;

  const FeatureEntity({
    required this.name,
    required this.value,
  });

  @override
  List<Object> get props => [name, value];
}

class CurrencyEntity extends Equatable {
  final String code;
  final String symbol;
  final int decimalDigits;
  final bool symbolOnLeft;
  final bool spaceBetweenAmountAndSymbol;
  final String thousandsSeparator;
  final String decimalSeparator;

  const CurrencyEntity({
    required this.code,
    required this.symbol,
    required this.decimalDigits,
    required this.symbolOnLeft,
    required this.spaceBetweenAmountAndSymbol,
    required this.thousandsSeparator,
    required this.decimalSeparator,
  });

  @override
  List<Object> get props => [
    code,
    symbol,
    decimalDigits,
    symbolOnLeft,
    spaceBetweenAmountAndSymbol,
    thousandsSeparator,
    decimalSeparator,
  ];
}