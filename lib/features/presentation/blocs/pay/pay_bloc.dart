import 'package:bloc/bloc.dart';
import 'package:gulf_sky_provider/features/domain/usecases/client/pay_for_package_subscription_usecase.dart';
import 'package:gulf_sky_provider/features/presentation/blocs/pay/pay_state.dart';

import '../../../domain/usecases/client/pay_for_order_usecase.dart';
import 'pay_event.dart';

class PayBloc extends Bloc<PayEvent, PayState> {
  final PayForOrderUseCase _payForOrderUseCase;
  final PayForPackageSubscriptionUseCase _payForPackageSubscriptionUseCase;

  PayBloc(
    this._payForOrderUseCase,
    this._payForPackageSubscriptionUseCase,
  ) : super(const Initial()) {

    on<PayForOrder>((event, emit) async {
      emit(const PayLoading());
      final result = await _payForOrderUseCase(event.parameters);
      result.fold(
        (l) => emit(PayFailed(errorMsg: l.message)),
        (r) {
          emit(const PaySucceeded());
        },
      );
    });

    on<PayForPackageSubscription>((event, emit) async {
      emit(const PayLoading());
      final result = await _payForPackageSubscriptionUseCase(event.parameters);
      result.fold(
        (l) => emit(PayFailed(errorMsg: l.message)),
        (r) {
          emit(const PaySucceeded());
        },
      );
    });
  }
}
