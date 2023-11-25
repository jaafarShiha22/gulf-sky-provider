import '../../../domain/entities/info/material_entity.dart';

class MaterialModel extends MaterialEntity{

  MaterialModel({
    required super.id,
    required super.name,
    required super.serialNumber,
    required super.price,
    required super.originalPrice,
    required super.quantity,
    required super.warrantyYears,
    required super.brandName,
    super.image,
    required super.branchId,
    required super.createdAt,
    required super.updatedAt,
  });

  factory MaterialModel.fromMap(Map<String, dynamic> json) => MaterialModel(
    id: json["id"],
    name: json["name"],
    serialNumber: json["serial_number"],
    price: json["price"],
    originalPrice: json["original_price"],
    quantity: json["quantity"],
    warrantyYears: json["warranty_years"],
    brandName: json["brand_name"],
    image: json["image"],
    branchId: json["branch_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

}
