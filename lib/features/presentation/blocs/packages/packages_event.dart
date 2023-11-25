import 'package:equatable/equatable.dart';
import 'package:gulf_sky_provider/features/domain/usecases/packages/subscribe_package_usecase.dart';

import '../../../domain/usecases/packages/unsubscribe_package_usecase.dart';

abstract class PackagesEvent extends Equatable {
  const PackagesEvent();

  @override
  List<Object> get props => [];
}

class GetMaintenancePackages extends PackagesEvent {
  const GetMaintenancePackages();

  @override
  List<Object> get props => [];
}

class SubscribePackage extends PackagesEvent {
  final SubscribePackageParameters parameters;
  const SubscribePackage(this.parameters);

  @override
  List<Object> get props => [];
}

class UnsubscribePackage extends PackagesEvent {
  final UnsubscribePackageParameters parameters;
  const UnsubscribePackage(this.parameters);

  @override
  List<Object> get props => [];
}
