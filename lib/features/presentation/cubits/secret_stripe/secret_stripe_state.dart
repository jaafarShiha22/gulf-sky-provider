part of 'secret_stripe_cubit.dart';

abstract class SecretStripeState extends Equatable {
  const SecretStripeState();

  @override
  List<Object> get props => [];
}

class SecretStipeInitial extends SecretStripeState {
  const SecretStipeInitial();
}
class SecretStipeLoading extends SecretStripeState {
  const SecretStipeLoading();
}

class SecretStipeSucceeded extends SecretStripeState {
  final String clientSecretStripe;

  const SecretStipeSucceeded({
    required this.clientSecretStripe,
  });
}

class SecretStipeFailed extends SecretStripeState {
  final String errorMsg;

  const SecretStipeFailed({
    required this.errorMsg,
  });
}

