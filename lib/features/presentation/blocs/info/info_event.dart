
import 'package:equatable/equatable.dart';
import 'package:gulf_sky_provider/features/domain/usecases/info/get_buildings_by_type_usecase.dart';

abstract class InfoEvent extends Equatable {
  const InfoEvent();

  @override
  List<Object> get props => [];
}

class GetBuildingsTypes extends InfoEvent {
  const GetBuildingsTypes();

  @override
  List<Object> get props => [];
}

class GetBuildingsByType extends InfoEvent {
  final BuildingsByTypeParameters parameters;
  const GetBuildingsByType({
    required this.parameters,
  });

  @override
  List<Object> get props => [];
}
