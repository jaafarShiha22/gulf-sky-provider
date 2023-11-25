import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/features/domain/entities/info/material_entity.dart';
import 'package:gulf_sky_provider/features/domain/entities/info/material_type_entityl.dart';
import 'package:gulf_sky_provider/features/domain/usecases/base_use_case.dart';

import '../../../core/error/failure.dart';
import '../entities/home/building_entity.dart';
import '../entities/home/building_type_entity.dart';
import '../entities/info/service_sections_entity.dart';
import '../entities/info/services_types_entity.dart';
import '../usecases/info/get_buildings_by_type_usecase.dart';
import '../usecases/info/get_materials_by_type_usecase.dart';
import '../usecases/info/get_service_sections_usecase.dart';

abstract class InfoRepository {
  Future<Either<Failure, List<BuildingTypeEntity>>> getBuildingsTypes();
  Future<Either<Failure, List<BuildingEntity>>> getBuildingsByType(BuildingsByTypeParameters parameters);

  Future<Either<Failure, List<ServiceTypeEntity>>> getServicesTypes();
  Future<Either<Failure, List<ServiceSectionEntity>>> getServiceSections(ServiceSectionsParameters parameters);
  Future<Either<Failure, List<MaterialTypeEntity>>> getMaterialsTypes(NoParameters parameters);
  Future<Either<Failure, List<MaterialEntity>>> getParametersByType(GetMaterialsByTypeParameters parameters);
}
