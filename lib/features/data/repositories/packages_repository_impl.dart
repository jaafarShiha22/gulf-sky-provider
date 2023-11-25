import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/core/error/failure.dart';
import 'package:gulf_sky_provider/features/domain/entities/package/package_entity.dart';
import 'package:gulf_sky_provider/features/domain/entities/package/subscribed_package_entity.dart';
import 'package:gulf_sky_provider/features/domain/repositories/packages_repository.dart';

import '../../domain/usecases/packages/subscribe_package_usecase.dart';
import '../../domain/usecases/packages/unsubscribe_package_usecase.dart';
import '../data_sources/packages_data_source.dart';

class PackagesRepositoryImpl extends PackagesRepository {
  final PackagesDataSource packagesDataSource;

  PackagesRepositoryImpl(this.packagesDataSource);

  @override
  Future<Either<Failure, List<PackageEntity>>> getPackages() async => await packagesDataSource.getPackages();

  @override
  Future<Either<Failure, SubscribedPackageEntity>> subscribePackage(SubscribePackageParameters parameters) async => await packagesDataSource.subscribePackage(parameters);

  @override
  Future<Either<Failure, void>> unsubscribePackage(UnsubscribePackageParameters parameters) async => await packagesDataSource.unsubscribePackage(parameters);
}
