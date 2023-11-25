part of 'rent_contract_info_cubit.dart';

abstract class RentContractInfoState extends Equatable {
  const RentContractInfoState();

  @override
  List<Object> get props => [];
}

class RentContractInfoInitial extends RentContractInfoState {}

class RentContractInfoLoading extends RentContractInfoState {}

class RentContractInfoFailure extends RentContractInfoState {
  final String errMessage;

  const RentContractInfoFailure(this.errMessage);
}

class RentContractInfoSuccess extends RentContractInfoState {
  final RentContractInfoEntity rentContractInfoEntity;

  const RentContractInfoSuccess(this.rentContractInfoEntity);
}
