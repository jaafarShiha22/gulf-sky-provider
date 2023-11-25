part of 'services_types_cubit.dart';

abstract class ServicesTypesState extends Equatable {
  const ServicesTypesState();

  @override
  List<Object> get props => [];
}

class ServicesTypesInitial extends ServicesTypesState {}

class ServicesTypesLoading extends ServicesTypesState {}

class ServicesTypesFailure extends ServicesTypesState {
  final String errMessage;

  const ServicesTypesFailure(this.errMessage);
}

class ServicesTypesSuccess extends ServicesTypesState {
  final List<ServiceTypeEntity> services;

  const ServicesTypesSuccess(this.services);
}
