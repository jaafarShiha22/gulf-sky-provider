import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulf_sky_provider/features/domain/usecases/info/get_materials_by_type_usecase.dart';

import '../../../domain/entities/info/material_entity.dart';

part 'materials_by_type_state.dart';

class MaterialsByTypeCubit extends Cubit<MaterialsByTypeState> {
  final GetMaterialsByTypeUseCase _getMaterialsByTypeUseCase;

  MaterialsByTypeCubit(this._getMaterialsByTypeUseCase) : super(GetMaterialsByTypeInitial());

  static MaterialsByTypeCubit get(context) => BlocProvider.of(context);

  Future<void> getMaterialsByType(GetMaterialsByTypeParameters parameters) async {
    emit(const GetMaterialsByTypeLoading());
    var result = await _getMaterialsByTypeUseCase(parameters);
    result.fold((failure) {
      emit(GetMaterialsByTypeFailed(errorMsg: failure.message,));
    }, (materials) {
      emit(GetMaterialsByTypeSucceeded(materialsByType: materials));
    });
  }
}
