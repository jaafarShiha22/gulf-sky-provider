import '../../../domain/entities/client/rent_contract_info_entity.dart';
import '../home/rent_model.dart';
import 'contract_active_model.dart';

class RentContractInfoModel extends RentContractInfoEntity{

  RentContractInfoModel({
    required super.rentActive,
    required super.contractActive,
  });

  factory RentContractInfoModel.fromMap(Map<String, dynamic> json) => RentContractInfoModel(
    rentActive: List<RentModel>.from(json["rent_active"].map((x) => RentModel.fromMap(x))),
    contractActive: List<ContractActiveModel>.from(json["contract_active"].map((x) => ContractActiveModel.fromMap(x))),
  );
}