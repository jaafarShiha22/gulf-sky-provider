part of 'service_sections_cubit.dart';

abstract class ServiceSectionsState extends Equatable {
  const ServiceSectionsState();

  @override
  List<Object> get props => [];
}

class ServiceSectionsInitial extends ServiceSectionsState {}

class ServiceSectionsLoading extends ServiceSectionsState {}

class ServiceSectionsFailure extends ServiceSectionsState {
  final String errMessage;

  const ServiceSectionsFailure(this.errMessage);
}

class ServiceSectionsSuccess extends ServiceSectionsState {
  final List<ServiceSectionEntity> serviceSections;

  const ServiceSectionsSuccess(this.serviceSections);
}
