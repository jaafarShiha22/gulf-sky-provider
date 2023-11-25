
import '../../../domain/entities/info/service_sections_entity.dart';

class ServiceSectionModel extends ServiceSectionEntity{

  ServiceSectionModel({
    required super.id,
    super.nameAr,
    required super.name,
    required super.serviceId,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ServiceSectionModel.fromMap(Map<String, dynamic> json) => ServiceSectionModel(
    id: json["id"],
    nameAr: json["name_ar"],
    name: json["name"],
    serviceId: json["service_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name_ar": nameAr,
    "name": name,
    "service_id": serviceId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
