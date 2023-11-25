import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gulf_sky_provider/features/domain/repositories/auth_repository.dart';

import '../../../../core/error/failure.dart';
import '../../entities/auth/auth_response_entity.dart';
import '../base_use_case.dart';

class LoginUseCase extends BaseUseCase<AuthResponseEntity, LoginParameters> {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  Future<Either<Failure, AuthResponseEntity>> call(LoginParameters parameters) async {
    return await _authRepository.login(parameters);
  }
}

class LoginParameters extends Equatable {
  final String username;
  final String password;

  const LoginParameters({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username];
}
