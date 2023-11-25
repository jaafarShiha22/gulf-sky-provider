import 'package:gulf_sky_provider/features/domain/entities/package/package_entity.dart';

class ContractActiveEntity {
    int id;
    String state;
    DateTime date;
    int price;
    List<PackageEntity> packages;

    ContractActiveEntity({
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