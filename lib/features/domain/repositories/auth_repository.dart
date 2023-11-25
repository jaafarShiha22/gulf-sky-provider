import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/features/domain/entities/auth/auth_response_entity.dart';
import 'package:gulf_sky_provider/features/domain/usecases/auth/change_fcm_token_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/auth/login_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/auth/register_usecase.dart';

import '../../../core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponseEntity>> login(LoginParameters parameters);
  Future<Either<Failure, AuthResponseEntity>> register(RegisterParameters parameters);
  Future<Either<Failure, AuthResponseEntity>> changeFCMToken(ChangeFCMTokenParameters parameters);
}
