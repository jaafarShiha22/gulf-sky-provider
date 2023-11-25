import 'package:equatable/equatable.dart';
import 'package:gulf_sky_provider/features/domain/usecases/client/pay_for_order_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/client/pay_for_package_subscription_usecase.dart';

abstract class PayEvent extends Equatable {
  const PayEvent();

  @override
  List<Object> get props => [];
}

class PayForOrder extends PayEvent {
  final PayForOrderParameters parameters;
  const PayForOrder(this.parameters);

  @override
  List<Object> get props => [];
}

class PayForPackageSubscription extends PayEvent {
  final PayForPackageSubscriptionParameters parameters;
  const PayForPackageSubscription(this.parameters);

  @override
  List<Object> get props => [];
}
