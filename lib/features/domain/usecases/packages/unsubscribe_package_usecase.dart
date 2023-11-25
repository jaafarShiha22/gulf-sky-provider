import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../entities/package/subscribed_package_entity.dart';
import '../../repositories/packages_repository.dart';
import '../base_use_case.dart';

class UnsubscribePackageUseCase extends BaseUseCase<void, UnsubscribePackageParameters> {
  final PackagesRepository _packagesRepository;

  UnsubscribePackageUseCase(this._packagesRepository);

  @override
  Future<Either<Failure, void>> call(UnsubscribePackageParameters parameters) async {
    return await _packagesRepository.unsubscribePackage(parameters);
  }
}

class UnsubscribePackageParameters extends Equatable {
  final int packageId;
  final bool isPackagePaid;

  const UnsubscribePackageParameters({
    required this.packageId,
    required this.isPackagePaid,
  });

  @override
  List<Object> get props => [packageId];
}
