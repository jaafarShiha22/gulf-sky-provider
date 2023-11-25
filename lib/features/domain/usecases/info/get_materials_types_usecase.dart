import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/features/domain/entities/info/material_type_entityl.dart';

import '../../../../core/error/failure.dart';
import '../../repositories/info_repository.dart';
import '../base_use_case.dart';

class GetMaterialsTypesUseCase extends BaseUseCase<List<MaterialTypeEntity>, NoParameters> {
  final InfoRepository _infoRepository;

  GetMaterialsTypesUseCase(this._infoRepository);

  @override
  Future<Either<Failure, List<MaterialTypeEntity>>> call(NoParameters parameters) async {
    return await _infoRepository.getMaterialsTypes(parameters);
  }
}
