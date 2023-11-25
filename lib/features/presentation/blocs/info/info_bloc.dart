import 'package:bloc/bloc.dart';
import 'package:gulf_sky_provider/features/domain/usecases/info/get_buildings_by_type_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/info/get_buildings_type_usecase.dart';
import 'package:gulf_sky_provider/features/presentation/blocs/info/info_state.dart';

import '../../../domain/usecases/base_use_case.dart';
import 'info_event.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  final GetBuildingsTypesUseCase _getBuildingsTypesUseCase;
  final GetBuildingsByTypeUseCase _getBuildingsByTypeUseCase;

  InfoBloc(
    this._getBuildingsTypesUseCase,
    this._getBuildingsByTypeUseCase,
  ) : super(const Initial()) {

    on<GetBuildingsTypes>((event, emit) async {
      emit(const GetBuildingsTypesLoading());
      final result = await _getBuildingsTypesUseCase(const NoParameters());
      result.fold(
        (l) => emit(GetBuildingsTypesFailed(errorMsg: l.message)),
        (r) {
          emit(GetBuildingsTypesSucceeded( buildingsTypes: r));
        },
      );
    });

    on<GetBuildingsByType>((event, emit) async {
      emit(const GetBuildingsByTypeLoading());
      final result = await _getBuildingsByTypeUseCase(
        event.parameters
      );
      result.fold(
            (l) => emit(GetBuildingsByTypeFailed(errorMsg: l.message)),
            (r) {
          emit(GetBuildingsByTypeSucceeded(buildingsByType: r));
        },
      );
    });
  }
}
