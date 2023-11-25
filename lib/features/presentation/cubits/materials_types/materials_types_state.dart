part of 'materials_types_cubit.dart';

abstract class MaterialsTypesState extends Equatable {
  const MaterialsTypesState();

  @override
  List<Object> get props => [];
}

class MaterialsTypesInitial extends MaterialsTypesState {}

class MaterialsTypesLoading extends MaterialsTypesState {
  const MaterialsTypesLoading();
}

class MaterialsTypesSucceeded extends MaterialsTypesState {
  final List<MaterialTypeEntity> materialsTypes;

  const MaterialsTypesSucceeded({
    required this.materialsTypes,
  });
}

class MaterialsTypesFailed extends MaterialsTypesState {
  final String errorMsg;

  const MaterialsTypesFailed({
    required this.errorMsg,
  });
}