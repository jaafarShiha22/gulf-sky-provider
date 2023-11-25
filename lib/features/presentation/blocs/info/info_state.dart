import 'package:gulf_sky_provider/features/domain/entities/home/building_entity.dart';
import 'package:gulf_sky_provider/features/domain/entities/home/building_type_entity.dart';

abstract class InfoState {
  const InfoState();
}

class Initial extends InfoState {
  const Initial();
}


class GetBuildingsTypesLoading extends InfoState {
  const GetBuildingsTypesLoading();
}

class GetBuildingsTypesSucceeded extends InfoState {
  final List<BuildingTypeEntity> buildingsTypes;

  const GetBuildingsTypesSucceeded({
    required this.buildingsTypes,
  });
}

class GetBuildingsTypesFailed extends InfoState {
  final String errorMsg;

  const GetBuildingsTypesFailed({
    required this.errorMsg,
  });
}

class GetBuildingsByTypeLoading extends InfoState {
  const GetBuildingsByTypeLoading();
}

class GetBuildingsByTypeSucceeded extends InfoState {
  final List<BuildingEntity> buildingsByType;

  const GetBuildingsByTypeSucceeded({
    required this.buildingsByType,
  });
}

class GetBuildingsByTypeFailed extends InfoState {
  final String errorMsg;

  const GetBuildingsByTypeFailed({
    required this.errorMsg,
  });
}


