import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../entities/package/package_entity.dart';
import '../entities/package/subscribed_package_entity.dart';
import '../usecases/packages/subscribe_package_usecase.dart';
import '../usecases/packages/unsubscribe_package_usecase.dart';

abstract class PackagesRepository {
  Future<Either<Failure, List<PackageEntity>>> getPackages();
  Future<Either<Failure, SubscribedPackageEntity>> subscribePackage(SubscribePackageParameters parameters);
  Future<Either<Failure, void>> unsubscribePackage(UnsubscribePackageParameters parameters);

}
