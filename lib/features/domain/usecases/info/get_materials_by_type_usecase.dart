import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gulf_sky_provider/features/domain/entities/info/material_entity.dart';

import '../../../../core/error/failure.dart';
import '../../repositories/info_repository.dart';
import '../base_use_case.dart';

class GetMaterialsByTypeUseCase extends BaseUseCase<List<MaterialEntity>, GetMaterialsByTypeParameters> {
  final InfoRepository _infoRepository;

  GetMaterialsByTypeUseCase(this._infoRepository);

  @override
  Future<Either<Failure, List<MaterialEntity>>> call(GetMaterialsByTypeParameters parameters) async {
    return await _infoRepository.getParametersByType(parameters);
  }
}

class GetMaterialsByTypeParameters extends Equatable {
  final int typeId;

  const GetMaterialsByTypeParameters({
    required this.typeId,
  });

  @override
  List<Object> get props => [typeId];
}
