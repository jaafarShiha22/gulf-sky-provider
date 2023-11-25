import '../../../domain/entities/info/material_type_entityl.dart';

class MaterialTypeModel extends MaterialTypeEntity{

  MaterialTypeModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.updatedAt,
  });

  factory MaterialTypeModel.fromMap(Map<String, dynamic> json) => MaterialTypeModel(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}