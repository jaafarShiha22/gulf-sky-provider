import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../entities/package/subscribed_package_entity.dart';
import '../../repositories/packages_repository.dart';
import '../base_use_case.dart';

class SubscribePackageUseCase extends BaseUseCase<SubscribedPackageEntity, SubscribePackageParameters> {
  final PackagesRepository _packagesRepository;

  SubscribePackageUseCase(this._packagesRepository);

  @override
  Future<Either<Failure, SubscribedPackageEntity>> call(SubscribePackageParameters parameters) async {
    return await _packagesRepository.subscribePackage(parameters);
  }
}

class SubscribePackageParameters extends Equatable {
  final int packageId;

  const SubscribePackageParameters({
    required this.packageId,
  });

  @override
  List<Object> get props => [packageId];
}
