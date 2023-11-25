import 'package:gulf_sky_provider/features/domain/entities/package/package_entity.dart';

import '../../../domain/entities/package/subscribed_package_entity.dart';

abstract class PackagesState {
  const PackagesState();
}

class Initial extends PackagesState {
  const Initial();
}

class GetMaintenancePackagesLoading extends PackagesState {
  const GetMaintenancePackagesLoading();
}

class GetMaintenancePackagesSucceeded extends PackagesState {
  final List<PackageEntity> packages;

  const GetMaintenancePackagesSucceeded({
    required this.packages,
  });
}

class GetMaintenancePackagesFailed extends PackagesState {
  final String errorMsg;

  const GetMaintenancePackagesFailed({
    required this.errorMsg,
  });
}

class SubscribePackageLoading extends PackagesState {
  const SubscribePackageLoading();
}

class SubscribePackageSucceeded extends PackagesState {
  final SubscribedPackageEntity subscribedPackageEntity;

  const SubscribePackageSucceeded({
    required this.subscribedPackageEntity,
  });
}

class SubscribePackageFailed extends PackagesState {
  final String errorMsg;

  const SubscribePackageFailed({
    required this.errorMsg,
  });
}


class UnsubscribePackageLoading extends PackagesState {
  const UnsubscribePackageLoading();
}

class UnsubscribePackageSucceeded extends PackagesState {

  const UnsubscribePackageSucceeded();
}

class UnsubscribePackageFailed extends PackagesState {
  final String errorMsg;

  const UnsubscribePackageFailed({
    required this.errorMsg,
  });
}

