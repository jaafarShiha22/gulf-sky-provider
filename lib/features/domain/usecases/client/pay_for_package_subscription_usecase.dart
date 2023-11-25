import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gulf_sky_provider/features/domain/repositories/client_repository.dart';

import '../../../../core/error/failure.dart';
import '../base_use_case.dart';

class PayForPackageSubscriptionUseCase extends BaseUseCase<void, PayForPackageSubscriptionParameters> {
  final ClientRepository _clientRepository;

  PayForPackageSubscriptionUseCase(this._clientRepository);

  @override
  Future<Either<Failure, void>> call(PayForPackageSubscriptionParameters parameters) async =>
      await _clientRepository.payForPackageSubscription(parameters);
}

class PayForPackageSubscriptionParameters extends Equatable {
  final String paymentSecret;
  final String cardNumber;
  final String expireDate;
  final String cvv;
  final int packageId;

  const PayForPackageSubscriptionParameters({
    required this.paymentSecret,
    required this.cardNumber,
    required this.expireDate,
    required this.cvv,
    required this.packageId,
  });

  @override
  List<Object?> get props => [];
}
