import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gulf_sky_provider/features/domain/repositories/auth_repository.dart';

import '../../../../core/error/failure.dart';
import '../../entities/auth/auth_response_entity.dart';
import '../base_use_case.dart';

class RegisterUseCase extends BaseUseCase<AuthResponseEntity, RegisterParameters> {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  @override
  Future<Either<Failure, AuthResponseEntity>> call(RegisterParameters parameters) async {
    return await _authRepository.register(parameters);
  }
}

class RegisterParameters extends Equatable {
  final String name;
  final String email;
  final String username;
  final String phone;
  final String mobile;
  final String address;
  final File? image;
  final String password;

  const RegisterParameters({
    required this.email,
    required this.password,
    required this.username,
    required this.name,
    required this.phone,
    required this.mobile,
    required this.address,
     this.image,
  });

  @override
  List<Object> get props => [email];
}
