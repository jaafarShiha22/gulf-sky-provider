import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gulf_sky_provider/features/domain/repositories/info_repository.dart';

import '../../../../core/error/failure.dart';
import '../../entities/home/building_entity.dart';
import '../base_use_case.dart';

class GetBuildingsByTypeUseCase extends BaseUseCase<List<BuildingEntity>, BuildingsByTypeParameters> {
  final InfoRepository _infoRepository;

  GetBuildingsByTypeUseCase(this._infoRepository);

  @override
  Future<Either<Failure, List<BuildingEntity>>> call(BuildingsByTypeParameters parameters) async {
    return await _infoRepository.getBuildingsByType(parameters);
  }
}

class BuildingsByTypeParameters extends Equatable {
  final int typeId;

  const BuildingsByTypeParameters({
    required this.typeId,
  });

  @override
  List<Object> get props => [typeId];
}
