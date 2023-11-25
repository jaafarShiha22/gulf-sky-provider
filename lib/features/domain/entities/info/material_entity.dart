import 'package:flutter/material.dart';

class MaterialEntity {
  int id;
  String name;
  String serialNumber;
  int price;
  int originalPrice;
  int quantity;
  int warrantyYears;
  String brandName;
  String? image;
  int branchId;
  DateTime createdAt;
  DateTime updatedAt;
  ValueNotifier<int>? selectedQuantity;

  MaterialEntity({
    required this.id,
    required this.name,
    required this.serialNumber,
    required this.price,
    required this.originalPrice,
    required this.quantity,
    required this.warrantyYears,
    required this.brandName,
    this.image,
    required this.branchId,
    required this.createdAt,
    required this.updatedAt,
    this.selectedQuantity,
  }) {
    selectedQuantity = ValueNotifier(1);
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "serial_number": serialNumber,
    "price": price,
    "original_price": originalPrice,
    "quantity": quantity,
    "warranty_years": warrantyYears,
    "brand_name": brandName,
    "image": image,
    "branch_id": branchId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };

  @override
  String toString() => '$name / $serialNumber';
}
