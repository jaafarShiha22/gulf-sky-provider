import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../entities/info/services_types_entity.dart';
import '../../repositories/info_repository.dart';
import '../base_use_case.dart';

class GetServicesTypesUseCase extends BaseUseCase<List<ServiceTypeEntity>, NoParameters> {
  final InfoRepository _infoRepository;

  GetServicesTypesUseCase(this._infoRepository);

  @override
  Future<Either<Failure, List<ServiceTypeEntity>>> call(NoParameters parameters) async {
    return await _infoRepository.getServicesTypes();
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
