import '../../../domain/entities/home/building_type_entity.dart';

class BuildingTypeModel extends BuildingTypeEntity{


    BuildingTypeModel({
        required super.id,
        required super.name,
        super.createdAt,
        super.updatedAt,
    });

    factory BuildingTypeModel.fromMap(Map<String, dynamic> json) => BuildingTypeModel(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}