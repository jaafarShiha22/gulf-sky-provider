import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gulf_sky_provider/core/api/urls.dart';
import 'package:gulf_sky_provider/core/error/failure.dart';
import 'package:gulf_sky_provider/core/utils/dio_utils.dart';
import 'package:gulf_sky_provider/features/data/models/info/material_type_model.dart';
import 'package:gulf_sky_provider/features/data/models/info/service_section_model.dart';
import 'package:gulf_sky_provider/features/domain/usecases/base_use_case.dart';
import 'package:gulf_sky_provider/features/domain/usecases/info/get_service_sections_usecase.dart';

import '../../../core/api/api_result.dart';
import '../../../core/api/api_services.dart';
import '../../domain/usecases/info/get_buildings_by_type_usecase.dart';
import '../../domain/usecases/info/get_materials_by_type_usecase.dart';
import '../models/home/building_model.dart';
import '../models/home/building_type_model.dart';
import '../models/info/material_model.dart';
import '../models/info/service_type_model.dart';

abstract class InfoDataSource {

  Future<Either<Failure, List<BuildingTypeModel>>> getBuildingsTypes();

  Future<Either<Failure, List<BuildingModel>>> getBuildingsByType(BuildingsByTypeParameters parameters);


  Future<Either<Failure, List<ServiceTypeModel>>> getServicesTypes();

  Future<Either<Failure, List<ServiceSectionModel>>> getServiceSections(ServiceSectionsParameters parameters);

  Future<Either<Failure, List<MaterialTypeModel>>> getMaterialsTypes(NoParameters parameters);

  Future<Either<Failure, List<MaterialModel>>> getMaterialsByType(GetMaterialsByTypeParameters parameters);
}

class InfoDataSourceImpl extends InfoDataSource {
  final ApiService _apiService;

  InfoDataSourceImpl(this._apiService);

  @override
  Future<Either<Failure, List<BuildingTypeModel>>> getBuildingsTypes() async {
    ApiResult result = await _apiService.post(
        endPoint: URLs.getBuildingsTypes,
        data: FormData.fromMap({}),
        options: DioUtils.getOptions(
          accept: true,
          contentType: true,
        ));
    if (result.type == ApiResultType.success) {
      return right((result.data as List)
          .map(
            (buildingTypeModel) => BuildingTypeModel.fromMap(buildingTypeModel),
      )
          .toList());
    } else {
      return left(Failure(message: result.message));
    }
  }

  @override
  Future<Either<Failure, List<BuildingModel>>> getBuildingsByType(BuildingsByTypeParameters parameters) async {
    ApiResult result = await _apiService.post(
        endPoint: URLs.getBuildingsByType,
        data: FormData.fromMap({
          'type_id': parameters.typeId,
        }),
        options: DioUtils.getOptions(
          accept: true,
          contentType: true,
        ));
    if (result.type == ApiResultType.success) {
      return right((result.data as List)
          .map(
            (buildingModel) => BuildingModel.fromMap(buildingModel),
      )
          .toList());
    } else {
      return left(Failure(message: result.message));
    }
  }


  @override
  Future<Either<Failure, List<ServiceTypeModel>>> getServicesTypes() async {
    ApiResult result = await _apiService.post(
        endPoint: URLs.getServicesTypes,
        data: FormData.fromMap({}),
        options: DioUtils.getOptions(
          accept: true,
          contentType: true,
        ));
    if (result.type == ApiResultType.success) {
      return right((result.data as List)
          .map(
            (serviceTypeModel) => ServiceTypeModel.fromMap(serviceTypeModel),
          )
          .toList());
    } else {
      return left(Failure(message: result.message));
    }
  }

  @override
  Future<Either<Failure, List<ServiceSectionModel>>> getServiceSections(ServiceSectionsParameters parameters) async {
    ApiResult result = await _apiService.post(
        endPoint: URLs.getServiceSections,
        data: FormData.fromMap({
          'service_id': parameters.serviceId,
        }),
        options: DioUtils.getOptions(
          accept: true,
          contentType: true,
        ));
    if (result.type == ApiResultType.success) {
      return right((result.data as List)
          .map(
            (serviceSectionModel) => ServiceSectionModel.fromMap(serviceSectionModel),
          )
          .toList());
    } else {
      return left(Failure(message: result.message));
    }
  }

  @override
  Future<Either<Failure, List<MaterialModel>>> getMaterialsByType(GetMaterialsByTypeParameters parameters) async {
    ApiResult result = await _apiService.post(
        endPoint: URLs.getMaterialsByType,
        data: FormData.fromMap({
          'type_id': parameters.typeId,
        }),
        options: DioUtils.getOptions(
          accept: true,
          contentType: true,
          withToken: true
        ));
    if (result.type == ApiResultType.success) {
      return right((result.data as List)
          .map(
            (materialModel) => MaterialModel.fromMap(materialModel),
      )
          .toList());
    } else {
      return left(Failure(message: result.message));
    }
  }

  @override
  Future<Either<Failure, List<MaterialTypeModel>>> getMaterialsTypes(NoParameters parameters) async {
    ApiResult result = await _apiService.post(
        endPoint: URLs.getMaterialsTypes,
        data: FormData.fromMap({}),
        options: DioUtils.getOptions(
          accept: true,
          withToken: true,
          contentType: true,
        ));
    if (result.type == ApiResultType.success) {
      return right((result.data as List)
          .map(
            (materialTypeModel) => MaterialTypeModel.fromMap(materialTypeModel),
      )
          .toList());
    } else {
      return left(Failure(message: result.message));
    }
  }
}
