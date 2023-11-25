import '../../../domain/entities/home/rent_entity.dart';
import 'building.dart';

class RentModel extends RentEntity{
  RentModel({
    required super.id,
    required super.from,
    required super.to,
    required super.state,
    super.note,
    required super.images,
    required super.building,
    required super.room,
    required super.evacuations,
  });

  factory RentModel.fromMap(Map<String, dynamic> json) => RentModel(
    id: json["id"],
    from: DateTime.parse(json["from"]),
    to: json["to"],
    state: json["state"],
    note: json["note"],
    images: json["images"],
    building: Building.fromMap(json["building"]),
    room: json["room"],
    evacuations: List<dynamic>.from(json["evacuations"].map((x) => x)),
  );


}
