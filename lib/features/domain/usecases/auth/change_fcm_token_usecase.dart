import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gulf_sky_provider/features/domain/repositories/auth_repository.dart';

import '../../../../core/error/failure.dart';
import '../../entities/auth/auth_response_entity.dart';
import '../base_use_case.dart';

class ChangeFCMTokenUseCase extends BaseUseCase<AuthResponseEntity, ChangeFCMTokenParameters> {
  final AuthRepository _authRepository;

  ChangeFCMTokenUseCase(this._authRepository);

  @override
  Future<Either<Failure, AuthResponseEntity>> call(ChangeFCMTokenParameters parameters) async {
    return await _authRepository.changeFCMToken(parameters);
  }
}

class ChangeFCMTokenParameters extends Equatable {
  final String fcmToken;

  const ChangeFCMTokenParameters({
    required this.fcmToken,
  });

  @override
  List<Object> get props => [fcmToken];
}
