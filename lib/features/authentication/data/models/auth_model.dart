// lib/features/authentication/data/models/auth_model.dart
import 'package:equatable/equatable.dart';
import 'package:workium/features/authentication/domain/entities/auth_entity.dart';

class AuthModel extends Equatable {
  final String accessToken;
  final String encryptedAccessToken;
  final int expireInSeconds;
  final bool shouldResetPassword;
  final String? passwordResetCode;
  final int userId;
  final bool requiresTwoFactorVerification;
  final String? twoFactorAuthProviders;
  final String? twoFactorRememberClientToken;
  final String? returnUrl;
  final String refreshToken;
  final int refreshTokenExpireInSeconds;


  const AuthModel({
    required this.accessToken,
    required this.encryptedAccessToken,
    required this.expireInSeconds,
    required this.shouldResetPassword,
    this.passwordResetCode,
    required this.userId,
    required this.requiresTwoFactorVerification,
    this.twoFactorAuthProviders,
    this.twoFactorRememberClientToken,
    this.returnUrl,
    required this.refreshToken,
    required this.refreshTokenExpireInSeconds,

  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json['accessToken'] ?? '',
      encryptedAccessToken: json['encryptedAccessToken'] ?? '',
      expireInSeconds: json['expireInSeconds'] ?? 0,
      shouldResetPassword: json['shouldResetPassword'] ?? false,
      passwordResetCode: json['passwordResetCode'],
      userId: json['userId'] ?? 0,
      requiresTwoFactorVerification: json['requiresTwoFactorVerification'] ?? false,
      twoFactorAuthProviders: json['twoFactorAuthProviders'],
      twoFactorRememberClientToken: json['twoFactorRememberClientToken'],
      returnUrl: json['returnUrl'],
      refreshToken: json['refreshToken'] ?? '',
      refreshTokenExpireInSeconds: json['refreshTokenExpireInSeconds'] ?? 0,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'encryptedAccessToken': encryptedAccessToken,
      'expireInSeconds': expireInSeconds,
      'shouldResetPassword': shouldResetPassword,
      'passwordResetCode': passwordResetCode,
      'userId': userId,
      'requiresTwoFactorVerification': requiresTwoFactorVerification,
      'twoFactorAuthProviders': twoFactorAuthProviders,
      'twoFactorRememberClientToken': twoFactorRememberClientToken,
      'returnUrl': returnUrl,
      'refreshToken': refreshToken,
      'refreshTokenExpireInSeconds': refreshTokenExpireInSeconds,

    };
  }

  AuthEntity toEntity() {
    return AuthEntity(
      accessToken: accessToken,
      encryptedAccessToken: encryptedAccessToken,
      expireInSeconds: expireInSeconds,
      shouldResetPassword: shouldResetPassword,
      passwordResetCode: passwordResetCode,
      userId: userId,
      requiresTwoFactorVerification: requiresTwoFactorVerification,
      twoFactorAuthProviders: twoFactorAuthProviders,
      twoFactorRememberClientToken: twoFactorRememberClientToken,
      returnUrl: returnUrl,
      refreshToken: refreshToken,
      refreshTokenExpireInSeconds: refreshTokenExpireInSeconds,

    );
  }

  @override
  List<Object?> get props => [
    accessToken,
    encryptedAccessToken,
    expireInSeconds,
    shouldResetPassword,
    passwordResetCode,
    userId,
    requiresTwoFactorVerification,
    twoFactorAuthProviders,
    twoFactorRememberClientToken,
    returnUrl,
    refreshToken,
    refreshTokenExpireInSeconds,

  ];
}