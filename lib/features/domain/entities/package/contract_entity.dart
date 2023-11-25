import 'package:gulf_sky_provider/features/domain/entities/package/package_entity.dart';

class ContractEntity {
  final int id;
  final String state;
  final DateTime date;
  final int price;
  final List<PackageEntity> packages;

  ContractEntity({
    required this.id,
    required this.state,
    required this.date,
    required this.price,
    required this.packages,
  });

  Map<String, dynamic> toMap() => {
    "id": id,
    "state": state,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "price": price,
    "packages": List<dynamic>.from(packages.map((x) => x.toMap())),
  };
}