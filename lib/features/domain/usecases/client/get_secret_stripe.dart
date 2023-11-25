import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/features/domain/repositories/client_repository.dart';

import '../../../../core/error/failure.dart';
import '../base_use_case.dart';

class GetSecretStripeUseCase extends BaseUseCase<String, NoParameters> {
  final ClientRepository _clientRepository;

  GetSecretStripeUseCase(this._clientRepository);

  @override
  Future<Either<Failure, String>> call(NoParameters parameters) async =>
     await _clientRepository.getClientSecretStripe();
}
