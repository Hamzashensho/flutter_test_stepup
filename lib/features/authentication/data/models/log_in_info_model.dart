// lib/features/authentication/data/models/login_info_model.dart
import 'package:equatable/equatable.dart';
import 'package:workium/features/authentication/domain/entities/login_info_entity.dart';

class LoginInfoModel extends Equatable {
  final UserModel? user;
  final TenantModel? tenant;
  final ApplicationModel? application;

  const LoginInfoModel({
    this.user,
    this.tenant,
    this.application,
  });

  factory LoginInfoModel.fromJson(Map<String, dynamic> json) {
    return LoginInfoModel(
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      tenant: json['tenant'] != null ? TenantModel.fromJson(json['tenant']) : null,
      application: json['application'] != null ? ApplicationModel.fromJson(json['application']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'tenant': tenant?.toJson(),
      'application': application?.toJson(),
    };
  }

  LoginInfoEntity toEntity() {
    return LoginInfoEntity(
      user: user?.toEntity(),
      tenant: tenant?.toEntity(),
      application: application?.toEntity(),
    );
  }

  @override
  List<Object?> get props => [user, tenant, application];
}

class UserModel extends Equatable {
  final String? id;
  final String? name;
  final String? surname;
  final String? userName;
  final String? emailAddress;
  final String? phoneNumber;
  final bool? isEmailConfirmed;
  final List<String>? roles;
  final String? profilePictureId;
  final bool? shouldChangePasswordOnNextLogin;
  final String? fullName;
  final String? profilePictureUrl;

  const UserModel({
    this.id,
    this.name,
    this.surname,
    this.userName,
    this.emailAddress,
    this.phoneNumber,
    this.isEmailConfirmed,
    this.roles,
    this.profilePictureId,
    this.shouldChangePasswordOnNextLogin,
    this.fullName,
    this.profilePictureUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString(),
      name: json['name'],
      surname: json['surname'],
      userName: json['userName'],
      emailAddress: json['emailAddress'],
      phoneNumber: json['phoneNumber'],
      isEmailConfirmed: json['isEmailConfirmed'],
      roles: json['roles'] != null ? List<String>.from(json['roles']) : null,
      profilePictureId: json['profilePictureId'],
      shouldChangePasswordOnNextLogin: json['shouldChangePasswordOnNextLogin'],
      fullName: json['fullName'],
      profilePictureUrl: json['profilePictureUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'userName': userName,
      'emailAddress': emailAddress,
      'phoneNumber': phoneNumber,
      'isEmailConfirmed': isEmailConfirmed,
      'roles': roles,
      'profilePictureId': profilePictureId,
      'shouldChangePasswordOnNextLogin': shouldChangePasswordOnNextLogin,
      'fullName': fullName,
      'profilePictureUrl': profilePictureUrl,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id ?? '',
      name: name ?? '',
      surname: surname ?? '',
      userName: userName ?? '',
      emailAddress: emailAddress ?? '',
      phoneNumber: phoneNumber,
      isEmailConfirmed: isEmailConfirmed ?? false,
      roles: roles ?? [],
      profilePictureId: profilePictureId,
      shouldChangePasswordOnNextLogin: shouldChangePasswordOnNextLogin ?? false,
      fullName: fullName ?? '',
      profilePictureUrl: profilePictureUrl,
    );
  }

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

class TenantModel extends Equatable {
  final String? id;
  final String? tenancyName;
  final String? name;
  final String? editionDisplayName;
  final bool? isInTrialPeriod;
  final DateTime? subscriptionEndDateUtc;
  final bool? isSubscriptionExpired;
  final DateTime? creationTime;

  const TenantModel({
    this.id,
    this.tenancyName,
    this.name,
    this.editionDisplayName,
    this.isInTrialPeriod,
    this.subscriptionEndDateUtc,
    this.isSubscriptionExpired,
    this.creationTime,
  });

  factory TenantModel.fromJson(Map<String, dynamic> json) {
    return TenantModel(
      id: json['id']?.toString(),
      tenancyName: json['tenancyName'],
      name: json['name'],
      editionDisplayName: json['editionDisplayName'],
      isInTrialPeriod: json['isInTrialPeriod'],
      subscriptionEndDateUtc: json['subscriptionEndDateUtc'] != null
          ? DateTime.parse(json['subscriptionEndDateUtc'])
          : null,
      isSubscriptionExpired: json['isSubscriptionExpired'],
      creationTime: json['creationTime'] != null
          ? DateTime.parse(json['creationTime'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tenancyName': tenancyName,
      'name': name,
      'editionDisplayName': editionDisplayName,
      'isInTrialPeriod': isInTrialPeriod,
      'subscriptionEndDateUtc': subscriptionEndDateUtc?.toIso8601String(),
      'isSubscriptionExpired': isSubscriptionExpired,
      'creationTime': creationTime?.toIso8601String(),
    };
  }

  TenantEntity toEntity() {
    return TenantEntity(
      id: id ?? '',
      tenancyName: tenancyName ?? '',
      name: name ?? '',
      editionDisplayName: editionDisplayName,
      isInTrialPeriod: isInTrialPeriod ?? false,
      subscriptionEndDateUtc: subscriptionEndDateUtc,
      isSubscriptionExpired: isSubscriptionExpired ?? false,
      creationTime: creationTime,
    );
  }

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

class ApplicationModel extends Equatable {
  final String? version;
  final DateTime? releaseDate;

  const ApplicationModel({
    this.version,
    this.releaseDate,
  });

  factory ApplicationModel.fromJson(Map<String, dynamic> json) {
    return ApplicationModel(
      version: json['version'],
      releaseDate: json['releaseDate'] != null
          ? DateTime.parse(json['releaseDate'])
          : null,


    );
  }

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'releaseDate': releaseDate?.toIso8601String(),
    };
  }

  ApplicationEntity toEntity() {
    return ApplicationEntity(
      version: version ?? '',
      releaseDate: releaseDate,
    );
  }

  @override
  List<Object?> get props => [version, releaseDate];
}

class FeatureModel extends Equatable {
  final String? name;
  final String? value;

  const FeatureModel({this.name, this.value});

  factory FeatureModel.fromJson(Map<String, dynamic> json) {
    return FeatureModel(
      name: json['name'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
    };
  }

  FeatureEntity toEntity() {
    return FeatureEntity(
      name: name ?? '',
      value: value ?? '',
    );
  }

  @override
  List<Object?> get props => [name, value];
}

class CurrencyModel extends Equatable {
  final String? code;
  final String? symbol;
  final int? decimalDigits;
  final bool? symbolOnLeft;
  final bool? spaceBetweenAmountAndSymbol;
  final String? thousandsSeparator;
  final String? decimalSeparator;

  const CurrencyModel({
    this.code,
    this.symbol,
    this.decimalDigits,
    this.symbolOnLeft,
    this.spaceBetweenAmountAndSymbol,
    this.thousandsSeparator,
    this.decimalSeparator,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      code: json['code'],
      symbol: json['symbol'],
      decimalDigits: json['decimalDigits'],
      symbolOnLeft: json['symbolOnLeft'],
      spaceBetweenAmountAndSymbol: json['spaceBetweenAmountAndSymbol'],
      thousandsSeparator: json['thousandsSeparator'],
      decimalSeparator: json['decimalSeparator'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'symbol': symbol,
      'decimalDigits': decimalDigits,
      'symbolOnLeft': symbolOnLeft,
      'spaceBetweenAmountAndSymbol': spaceBetweenAmountAndSymbol,
      'thousandsSeparator': thousandsSeparator,
      'decimalSeparator': decimalSeparator,
    };
  }

  CurrencyEntity toEntity() {
    return CurrencyEntity(
      code: code ?? '',
      symbol: symbol ?? '',
      decimalDigits: decimalDigits ?? 2,
      symbolOnLeft: symbolOnLeft ?? true,
      spaceBetweenAmountAndSymbol: spaceBetweenAmountAndSymbol ?? false,
      thousandsSeparator: thousandsSeparator ?? ',',
      decimalSeparator: decimalSeparator ?? '.',
    );
  }

  @override
  List<Object?> get props => [
    code,
    symbol,
    decimalDigits,
    symbolOnLeft,
    spaceBetweenAmountAndSymbol,
    thousandsSeparator,
    decimalSeparator,
  ];
}