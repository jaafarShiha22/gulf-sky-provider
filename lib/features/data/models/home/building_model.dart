import '../../../domain/entities/home/building_entity.dart';

class BuildingModel extends BuildingEntity{


    BuildingModel({
        required super.id,
        required super.name,
        required super.number,
        required super.description,
        required super.type,
        required super.roomNumber,
        required super.location,
        required super.images,
        required super.branchId,
        required super.createdAt,
        required super.updatedAt,
    });

    factory BuildingModel.fromMap(Map<String, dynamic> json) => BuildingModel(
        id: json["id"],
        name: json["name"],
        number: json["number"],
        description: json["description"],
        type: json["type"],
        roomNumber: json["room_number"],
        location: json["location"],
        images: json["images"],
        branchId: json["branch_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

}
