//
// import 'package:gulf_sky_provider/features/domain/entities/home/building_entity.dart';
//
// class RentActiveEntity {
//   int id;
//   DateTime from;
//   int to;
//   String state;
//   dynamic note;
//   String images;
//   BuildingEntity building;
//   String room;
//   List<dynamic> evacuations;
//
//   RentActiveEntity({
//     required this.id,
//     required this.from,
//     required this.to,
//     required this.state,
//     this.note,
//     required this.images,
//     required this.building,
//     required this.room,
//     required this.evacuations,
//   });
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "from": "${from.year.toString().padLeft(4, '0')}-${from.month.toString().padLeft(2, '0')}-${from.day.toString().padLeft(2, '0')}",
//     "to": to,
//     "state": state,
//     "note": note,
//     "images": images,
//     "building": building.toMap(),
//     "room": room,
//     "evacuations": List<dynamic>.from(evacuations.map((x) => x)),
//   };
// }