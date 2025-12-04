import 'package:workium/features/authentication/domain/entities/tenant_availability_entity.dart';

class TenantAvailabilityModel {
  final int? tenantId;

  TenantAvailabilityModel({
    this.tenantId,
  });

  factory TenantAvailabilityModel.fromJson(Map<String, dynamic> json) {
    return TenantAvailabilityModel(
      tenantId: json['tenantId'],
    );
  }

  TenantAvailabilityEntity toEntity() {
    return TenantAvailabilityEntity(
      tenantId: tenantId,
    );
  }
}