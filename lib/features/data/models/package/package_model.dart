import '../../../domain/entities/package/package_entity.dart';

class PackageModel extends PackageEntity{
    PackageModel({
        required super.id,
        required super.name,
        required super.nameAr,
        required super.descriptionAr,
        required super.description,
        required super.price,
        required super.createdAt,
        required super.updatedAt,
    });

    factory PackageModel.fromMap(Map<String, dynamic> json) => PackageModel(
        id: json["id"],
        name: json["name"],
        nameAr: json["name_ar"],
        descriptionAr: json["description_ar"],
        description: json["description"],
        price: json["price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

}