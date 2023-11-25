import 'package:gulf_sky_provider/features/data/models/package/package_model.dart';

import '../../../domain/entities/package/contract_entity.dart';

class ContractModel extends ContractEntity{

  ContractModel({
    required super.id,
    required super.state,
    required super.date,
    required super.price,
    required super.packages,
  });

  factory ContractModel.fromMap(Map<String, dynamic> json) => ContractModel(
    id: json["id"],
    state: json["state"],
    date: DateTime.parse(json["date"]),
    price: json["price"],
    packages: List<PackageModel>.from(json["packages"].map((x) => PackageModel.fromMap(x))),
  );

}