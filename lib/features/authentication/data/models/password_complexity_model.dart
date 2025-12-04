import 'package:workium/features/authentication/domain/entities/password_complexity_entity.dart';

class PasswordComplexityModel {
  final bool requireDigit;
  final bool requireLowercase;
  final bool requireNonAlphanumeric;
  final bool requireUppercase;
  final int requiredLength;

  PasswordComplexityModel({
    required this.requireDigit,
    required this.requireLowercase,
    required this.requireNonAlphanumeric,
    required this.requireUppercase,
    required this.requiredLength,
  });

  factory PasswordComplexityModel.fromJson(Map<String, dynamic> json) {
    return PasswordComplexityModel(
      requireDigit: json['setting']['requireDigit'] ?? false,
      requireLowercase: json['setting']['requireLowercase'] ?? false,
      requireNonAlphanumeric: json['setting']['requireNonAlphanumeric'] ?? false,
      requireUppercase: json['setting']['requireUppercase'] ?? false,
      requiredLength: json['setting']['requiredLength'] ?? 6,
    );
  }

  PasswordComplexityEntity toEntity() {
    return PasswordComplexityEntity(
      requireDigit: requireDigit,
      requireLowercase: requireLowercase,
      requireNonAlphanumeric: requireNonAlphanumeric,
      requireUppercase: requireUppercase,
      requiredLength: requiredLength,
    );
  }
}
