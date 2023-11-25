// import 'package:gulf_sky_provider/features/data/models/home/building_model.dart';
//
// import '../../../domain/entities/client/rent_active_entity.dart';
//
// class RentActiveModel extends RentActiveEntity {
//
//   RentActiveModel({
//     required super.id,
//     required super.from,
//     required super.to,
//     required super.state,
//     super.note,
//     required super.images,
//     required super.building,
//     required super.room,
//     required super.evacuations,
//   });
//
//   factory RentActiveModel.fromMap(Map<String, dynamic> json) => RentActiveModel(
//     id: json["id"],
//     from: DateTime.parse(json["from"]),
//     to: json["to"],
//     state: json["state"],
//     note: json["note"],
//     images: json["images"],
//     building: BuildingModel.fromMap(json["building"]),
//     room: json["room"],
//     evacuations: List<dynamic>.from(json["evacuations"].map((x) => x)),
//   );
//
// }