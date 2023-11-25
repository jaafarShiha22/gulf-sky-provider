import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gulf_sky_provider/features/domain/repositories/client_repository.dart';

import '../../../../core/error/failure.dart';
import '../base_use_case.dart';

class PayForOrderUseCase extends BaseUseCase<void, PayForOrderParameters> {
  final ClientRepository _clientRepository;

  PayForOrderUseCase(this._clientRepository);

  @override
  Future<Either<Failure, void>> call(PayForOrderParameters parameters) async =>
      await _clientRepository.payForOrder(parameters);
}

class PayForOrderParameters extends Equatable {
  final String paymentSecret;
  final String cardNumber;
  final String expireDate;
  final String cvv;
  final int orderId;

  const PayForOrderParameters({
    required this.paymentSecret,
    required this.cardNumber,
    required this.expireDate,
    required this.cvv,
    required this.orderId,
  });

  @override
  List<Object?> get props => [];
}
