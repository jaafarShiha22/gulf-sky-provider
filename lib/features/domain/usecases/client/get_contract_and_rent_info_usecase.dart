import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/features/domain/entities/client/rent_contract_info_entity.dart';
import 'package:gulf_sky_provider/features/domain/repositories/client_repository.dart';

import '../../../../core/error/failure.dart';
import '../base_use_case.dart';

class GetContractAndRentUseCase extends BaseUseCase<RentContractInfoEntity, NoParameters> {
  final ClientRepository _clientRepository;

  GetContractAndRentUseCase(this._clientRepository);

  @override
  Future<Either<Failure, RentContractInfoEntity>> call(NoParameters parameters) async {
    return await _clientRepository.getRentAndContractInfo();
  }
}
