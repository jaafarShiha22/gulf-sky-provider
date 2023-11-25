import 'package:bloc/bloc.dart';
import 'package:gulf_sky_provider/features/domain/usecases/request/add_evacuation_request_usecase.dart';
import 'package:gulf_sky_provider/features/presentation/blocs/add_request/add_request_state.dart';

import '../../../domain/usecases/request/add_maintenance_request_usecase.dart';
import 'add_request_event.dart';

class AddRequestBloc extends Bloc<AddRequestEvent, AddRequestState> {
  final AddMaintenanceRequestUseCase _addMaintenanceRequestUseCase;
  final AddEvacuationRequestUseCase _addEvacuationRequestUseCase;

  AddRequestBloc(
    this._addMaintenanceRequestUseCase,
    this._addEvacuationRequestUseCase,
  ) : super(const Initial()) {
    on<AddMaintenanceRequest>((event, emit) async {
      emit(const AddMaintenanceRequestLoading());
      final result = await _addMaintenanceRequestUseCase(
        event.parameters,
      );
      result.fold(
        (l) => emit(AddMaintenanceRequestFailed(errorMsg: l.message)),
        (r) {
          emit(AddMaintenanceRequestSucceeded(addMaintenanceResponseEntity: r));
        },
      );
    });

    on<AddEvacuationRequest>((event, emit) async {
      emit(const AddEvacuationRequestLoading());
      final result = await _addEvacuationRequestUseCase(
        event.parameters,
      );
      result.fold(
        (l) => emit(AddEvacuationRequestFailed(errorMsg: l.message)),
        (r) {
          emit(const AddEvacuationRequestSucceeded());
        },
      );
    });
  }
}
