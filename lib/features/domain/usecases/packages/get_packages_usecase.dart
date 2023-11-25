import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../entities/package/package_entity.dart';
import '../../repositories/packages_repository.dart';
import '../base_use_case.dart';

class GetPackagesUseCase extends BaseUseCase<List<PackageEntity>, NoParameters> {
  final PackagesRepository _packagesRepository;

  GetPackagesUseCase(this._packagesRepository);

  @override
  Future<Either<Failure, List<PackageEntity>>> call(NoParameters parameters) async {
    return await _packagesRepository.getPackages();
  }
}
