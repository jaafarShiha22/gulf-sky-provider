import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/core/error/failure.dart';
import 'package:gulf_sky_provider/features/data/data_sources/info_data_source.dart';
import 'package:gulf_sky_provider/features/domain/entities/info/material_entity.dart';
import 'package:gulf_sky_provider/features/domain/entities/info/material_type_entityl.dart';
import 'package:gulf_sky_provider/features/domain/entities/info/service_sections_entity.dart';
import 'package:gulf_sky_provider/features/domain/entities/info/services_types_entity.dart';
import 'package:gulf_sky_provider/features/domain/usecases/base_use_case.dart';
import 'package:gulf_sky_provider/features/domain/usecases/info/get_materials_by_type_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/info/get_service_sections_usecase.dart';

import '../../domain/entities/home/building_entity.dart';
import '../../domain/entities/home/building_type_entity.dart';
import '../../domain/repositories/info_repository.dart';
import '../../domain/usecases/info/get_buildings_by_type_usecase.dart';

class InfoRepositoryImpl extends InfoRepository {
  final InfoDataSource infoDataSource;

  InfoRepositoryImpl(this.infoDataSource);

  @override
  Future<Either<Failure, List<BuildingTypeEntity>>> getBuildingsTypes() async {
    return await infoDataSource.getBuildingsTypes();
  }

  @override
  Future<Either<Failure, List<BuildingEntity>>> getBuildingsByType(BuildingsByTypeParameters parameters) async {
    return await infoDataSource.getBuildingsByType(parameters);
  }

  @override
  Future<Either<Failure, List<ServiceTypeEntity>>> getServicesTypes() async => await infoDataSource.getServicesTypes();

  @override
  Future<Either<Failure, List<ServiceSectionEntity>>> getServiceSections(ServiceSectionsParameters parameters) async =>
      await infoDataSource.getServiceSections(parameters);

  @override
  Future<Either<Failure, List<MaterialTypeEntity>>> getMaterialsTypes(NoParameters parameters) async =>
      await infoDataSource.getMaterialsTypes(parameters);

  @override
  Future<Either<Failure, List<MaterialEntity>>> getParametersByType(GetMaterialsByTypeParameters parameters) async =>
      await infoDataSource.getMaterialsByType(parameters);
}
