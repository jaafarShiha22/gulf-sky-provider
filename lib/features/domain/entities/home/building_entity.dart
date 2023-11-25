class BuildingEntity {
  final int id;
  final String name;
  final String number;
  final String description;
  final String type;
  final int roomNumber;
  final String location;
  final String images;
  final int branchId;
  final DateTime createdAt;
  final DateTime updatedAt;

  BuildingEntity({
    required this.id,
    required this.name,
    required this.number,
    required this.description,
    required this.type,
    required this.roomNumber,
    required this.location,
    required this.images,
    required this.branchId,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "number": number,
    "description": description,
    "type": type,
    "room_number": roomNumber,
    "location": location,
    "images": images,
    "branch_id": branchId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };

}