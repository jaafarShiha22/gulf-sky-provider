import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/features/domain/entities/home/building_type_entity.dart';
import 'package:gulf_sky_provider/features/domain/repositories/info_repository.dart';

import '../../../../core/error/failure.dart';
import '../base_use_case.dart';

class GetBuildingsTypesUseCase extends BaseUseCase<List<BuildingTypeEntity>, NoParameters> {
  final InfoRepository _infoRepository;

  GetBuildingsTypesUseCase(this._infoRepository);

  @override
  Future<Either<Failure, List<BuildingTypeEntity>>> call(NoParameters parameters) async {
    return await _infoRepository.getBuildingsTypes();
  }
}
