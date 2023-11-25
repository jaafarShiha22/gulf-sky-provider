import 'package:gulf_sky_provider/features/domain/entities/client/contract_active_entity.dart';

import '../home/rent_entity.dart';

class RentContractInfoEntity {
  List<RentEntity> rentActive;
  List<ContractActiveEntity> contractActive;

  RentContractInfoEntity({
    required this.rentActive,
    required this.contractActive,
  });

  Map<String, dynamic> toMap() => {
    "rent_active": List<dynamic>.from(rentActive.map((x) => x.toMap())),
    "contract_active": List<dynamic>.from(contractActive.map((x) => x.toMap())),
  };
}