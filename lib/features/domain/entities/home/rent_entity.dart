import '../../../data/models/home/building.dart';

class RentEntity {
  final int id;
  final DateTime from;
  final int to;
  final String state;
  final dynamic note;
  final String images;
  final Building building;
  final String room;
  final List<dynamic> evacuations;

  RentEntity({
    required this.id,
    required this.from,
    required this.to,
    required this.state,
    this.note,
    required this.images,
    required this.building,
    required this.room,
    required this.evacuations,
  });

  Map<String, dynamic> toMap() => {
    "id": id,
    "from": "${from.year.toString().padLeft(4, '0')}-${from.month.toString().padLeft(2, '0')}-${from.day.toString().padLeft(2, '0')}",
    "to": to,
    "state": state,
    "note": note,
    "images": images,
    "building": building.toMap(),
    "room": room,
    "evacuations": List<dynamic>.from(evacuations.map((x) => x)),
  };

  @override
  String toString() => '${building.roomNumber} /${building.name}';
}