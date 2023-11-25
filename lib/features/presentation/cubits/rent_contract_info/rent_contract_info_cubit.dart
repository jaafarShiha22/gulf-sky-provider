import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulf_sky_provider/features/domain/entities/client/rent_contract_info_entity.dart';
import 'package:gulf_sky_provider/features/domain/usecases/client/get_contract_and_rent_info_usecase.dart';

import '../../../domain/usecases/base_use_case.dart';

part 'rent_contract_info_state.dart';

class RentContractInfoCubit extends Cubit<RentContractInfoState> {
  final GetContractAndRentUseCase _getContractAndRentUseCase;

  RentContractInfoCubit(this._getContractAndRentUseCase) : super(RentContractInfoInitial());

  static RentContractInfoCubit get(context) => BlocProvider.of(context);

  RentContractInfoEntity? rentContractInfo;

  Future<void> getContractAndRent() async {
    emit(RentContractInfoLoading());
    var result = await _getContractAndRentUseCase(const NoParameters());
    result.fold((failure) {
      emit(RentContractInfoFailure(failure.message));
    }, (rentContractInfoEntity) {
      rentContractInfo = rentContractInfoEntity;
      emit(RentContractInfoSuccess(rentContractInfoEntity));
    });
  }
}
