import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulf_sky_provider/features/domain/usecases/info/get_services_types_usecase.dart';

import '../../../domain/entities/info/services_types_entity.dart';
import '../../../domain/usecases/base_use_case.dart';

part 'services_types_state.dart';

class ServicesTypesCubit extends Cubit<ServicesTypesState> {
  final GetServicesTypesUseCase _getServicesTypesUseCase;

  ServicesTypesCubit(this._getServicesTypesUseCase) : super(ServicesTypesInitial());

  static ServicesTypesCubit get(context) => BlocProvider.of(context);

  Future<void> getServicesTypes() async {
    emit(ServicesTypesLoading());
    var result = await _getServicesTypesUseCase(const NoParameters());
    result.fold((failure) {
      emit(ServicesTypesFailure(failure.message));
    }, (services) {
      emit(ServicesTypesSuccess(services));
    });
  }
}
