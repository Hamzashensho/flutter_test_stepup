// lib/features/authentication/data/models/edition_model.dart
import 'package:equatable/equatable.dart';
import 'package:workium/features/authentication/domain/entities/edition_entity.dart';

class EditionModel extends Equatable {
  final String id;
  final String name;
  final String displayName;
  final bool isRegistrable;
  final double? monthlyPrice;
  final double? annualPrice;
  final bool hasTrial;
  final bool? isMostPopular;
  final Map<String, String> features;

  const EditionModel({
    required this.id,
    required this.name,
    required this.displayName,
    required this.isRegistrable,
    this.monthlyPrice,
    this.annualPrice,
    required this.hasTrial,
    this.isMostPopular,
    required this.features,
  });

  factory EditionModel.fromJson(Map<String, dynamic> json) {
    final edition = json['edition'];
    final featureValues = json['featureValues'] as List? ?? [];

    // Parse features from featureValues
    final features = <String, String>{};
    for (final feature in featureValues) {
      final name = feature['name']?.toString();
      final value = feature['value']?.toString();
      if (name != null && value != null) {
        features[name] = value;
      }
    }

    return EditionModel(
      id: edition['id']?.toString() ?? '',
      name: edition['name']?.toString() ?? '',
      displayName: edition['displayName']?.toString() ?? '',
      isRegistrable: edition['isRegistrable'] ?? false,
      monthlyPrice: edition['monthlyPrice']?.toDouble(),
      annualPrice: edition['annualPrice']?.toDouble(),
      hasTrial: edition['hasTrial'] ?? false,
      isMostPopular: edition['isMostPopular'],
      features: features,
    );
  }

  EditionEntity toEntity() {
    return EditionEntity(
      id: id,
      name: name,
      displayName: displayName,
      isRegistrable: isRegistrable,
      monthlyPrice: monthlyPrice,
      annualPrice: annualPrice,
      hasTrial: hasTrial,
      isMostPopular: isMostPopular ?? false,
      features: features,
    );
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