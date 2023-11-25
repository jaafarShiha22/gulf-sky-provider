import 'package:gulf_sky_provider/features/data/models/package/package_model.dart';

import '../../../domain/entities/client/contract_active_entity.dart';

class ContractActiveModel extends ContractActiveEntity {
  ContractActiveModel({
    required super.id,
    required super.state,
    required super.date,
    required super.price,
    required super.packages,
  });

  factory ContractActiveModel.fromMap(Map<String, dynamic> json) => ContractActiveModel(
        id: json["id"],
        state: json["state"],
        date: DateTime.parse(json["date"]),
        price: json["price"],
        packages: List<PackageModel>.from(json["packages"].map((x) => PackageModel.fromMap(x))),
      );
}
