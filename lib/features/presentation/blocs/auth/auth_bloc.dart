import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:gulf_sky_provider/features/domain/usecases/auth/change_fcm_token_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/auth/register_usecase.dart';
import 'package:gulf_sky_provider/features/presentation/blocs/auth/auth_event.dart';
import 'package:gulf_sky_provider/features/presentation/blocs/auth/auth_state.dart';

import '../../../domain/entities/auth/auth_response_entity.dart';
import '../../../domain/usecases/auth/login_usecase.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase _registerUseCase;
  final LoginUseCase _loginUseCase;
  final ChangeFCMTokenUseCase _changeFCMTokenUseCase;

  AuthBloc(
    this._registerUseCase,
    this._loginUseCase,
    this._changeFCMTokenUseCase,
  ) : super(const Initial()) {
    on<Register>((event, emit) async {
      emit(const RegisterLoading());
      final result = await _registerUseCase(
        event.parameters,
      );
      result.fold(
        (l) => emit(RegisterFailed(errorMsg: l.message)),
        (r) {
          GetIt.instance.registerLazySingleton<AuthResponseEntity>(() => r);
          add(const ChangeFCMToken());
          emit(RegisterSucceeded(authResponseEntity: r));
        },
      );
    });
    on<Login>((event, emit) async {
      emit(const LoginLoading());
      final result = await _loginUseCase(
        event.parameters,
      );
      result.fold(
        (l) => emit(LoginFailed(errorMsg: l.message)),
        (r) {
          GetIt.instance.registerLazySingleton<AuthResponseEntity>(() => r);
          add(const ChangeFCMToken());
          emit(LoginSucceeded(authResponseEntity: r));
        },
      );
    });
    on<ChangeFCMToken>((event, emit) async {
      emit(const ChangeFCMTokenLoading());
      await FirebaseMessaging.instance.getToken().then((fcmToken) async {
        if (fcmToken != null) {
          final result = await _changeFCMTokenUseCase(
            ChangeFCMTokenParameters(fcmToken: fcmToken),
          );
          result.fold(
            (l) => emit(ChangeFCMTokenFailed(errorMsg: l.message)),
            (r) {
              GetIt.instance.unregister<AuthResponseEntity>();
              GetIt.instance.registerLazySingleton<AuthResponseEntity>(() => r);
              emit(ChangeFCMTokenSucceeded(authResponseEntity: r));
            },
          );
          return;
        }
      }, onError: (e) {
        emit(ChangeFCMTokenFailed(errorMsg: e.toString()));
      });
    });
  }
}
