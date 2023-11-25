import '../../../domain/entities/info/services_types_entity.dart';

class ServiceTypeModel extends ServiceTypeEntity{

  ServiceTypeModel({
    required super.id,
    super.nameAr,
    required super.name,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ServiceTypeModel.fromMap(Map<String, dynamic> json) => ServiceTypeModel(
    id: json["id"],
    nameAr: json["name_ar"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name_ar": nameAr,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
