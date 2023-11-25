class MaterialTypeEntity {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  MaterialTypeEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };

  @override
  String toString() => name;
}