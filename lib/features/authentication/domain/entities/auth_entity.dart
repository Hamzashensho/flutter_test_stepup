class AuthEntity {
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

  AuthEntity({
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
}