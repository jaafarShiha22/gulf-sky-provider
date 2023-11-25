part of 'materials_by_type_cubit.dart';

abstract class MaterialsByTypeState extends Equatable {
  const MaterialsByTypeState();

  @override
  List<Object> get props => [];
}

class GetMaterialsByTypeInitial extends MaterialsByTypeState {}

class GetMaterialsByTypeLoading extends MaterialsByTypeState {
  const GetMaterialsByTypeLoading();
}

class GetMaterialsByTypeSucceeded extends MaterialsByTypeState {
  final List<MaterialEntity> materialsByType;

  const GetMaterialsByTypeSucceeded({
    required this.materialsByType,
  });
}

class GetMaterialsByTypeFailed extends MaterialsByTypeState {
  final String errorMsg;

  const GetMaterialsByTypeFailed({
    required this.errorMsg,
  });
}