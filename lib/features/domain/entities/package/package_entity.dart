class PackageEntity {
  final int id;
  final String name;
  final String nameAr;
  final String descriptionAr;
  final String description;
  final int price;
  final DateTime createdAt;
  final DateTime updatedAt;

  PackageEntity({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.descriptionAr,
    required this.description,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "name_ar": nameAr,
    "description_ar": descriptionAr,
    "description": description,
    "price": price,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}