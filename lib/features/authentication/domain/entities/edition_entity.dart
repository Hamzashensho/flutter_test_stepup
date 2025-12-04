// lib/features/authentication/domain/entities/edition_entity.dart
import 'package:equatable/equatable.dart';

class EditionEntity extends Equatable {
  final String id;
  final String name;
  final String displayName;
  final bool isRegistrable;
  final double? monthlyPrice;
  final double? annualPrice;
  final bool hasTrial;
  final bool isMostPopular;
  final Map<String, String> features; // Changed to String values

  const EditionEntity({
    required this.id,
    required this.name,
    required this.displayName,
    required this.isRegistrable,
    this.monthlyPrice,
    this.annualPrice,
    required this.hasTrial,
    required this.isMostPopular,
    required this.features,
  });

  String? get priceDisplay {
    if (monthlyPrice != null) {
      return '\$$monthlyPrice/month';
    }
    return 'Free';
  }

  @override
  List<Object?> get props => [
    id,
    name,
    displayName,
    isRegistrable,
    monthlyPrice,
    annualPrice,
    hasTrial,
    isMostPopular,
    features,
  ];
}