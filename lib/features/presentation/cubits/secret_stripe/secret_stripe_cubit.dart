import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulf_sky_provider/features/domain/usecases/client/get_secret_stripe.dart';

import '../../../domain/usecases/base_use_case.dart';

part 'secret_stripe_state.dart';

class SecretStripeCubit extends Cubit<SecretStripeState> {
  final GetSecretStripeUseCase _getSecretStripeUseCase;

  SecretStripeCubit(this._getSecretStripeUseCase) : super(const SecretStipeInitial());

  static SecretStripeCubit get(context) => BlocProvider.of(context);

  Future<void> getSecretStripe() async {
    emit(const SecretStipeLoading());
    var result = await _getSecretStripeUseCase(const NoParameters());
    result.fold((failure) {
      emit(SecretStipeFailed(errorMsg: failure.message));
    }, (clientSecretStripe) {
      emit(SecretStipeSucceeded(clientSecretStripe: clientSecretStripe));
    });
  }
}
