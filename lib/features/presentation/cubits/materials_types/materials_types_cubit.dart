import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulf_sky_provider/features/domain/usecases/info/get_materials_types_usecase.dart';

import '../../../domain/entities/info/material_type_entityl.dart';
import '../../../domain/usecases/base_use_case.dart';

part 'materials_types_state.dart';

class MaterialsTypesCubit extends Cubit<MaterialsTypesState> {
  final GetMaterialsTypesUseCase _getMaterialsTypesUseCase;

  MaterialsTypesCubit(this._getMaterialsTypesUseCase) : super(MaterialsTypesInitial());

  static MaterialsTypesCubit get(context) => BlocProvider.of(context);

  Future<void> getMaterialsTypes() async {
    emit(const MaterialsTypesLoading());
    var result = await _getMaterialsTypesUseCase(const NoParameters());
    result.fold((failure) {
      emit(MaterialsTypesFailed(errorMsg: failure.message,));
    }, (services) {
      emit(MaterialsTypesSucceeded(materialsTypes: services));
    });
  }
}
