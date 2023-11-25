import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gulf_sky_provider/core/api/urls.dart';
import 'package:gulf_sky_provider/core/error/failure.dart';
import 'package:gulf_sky_provider/core/utils/dio_utils.dart';
import 'package:gulf_sky_provider/features/data/models/auth/auth_response_model.dart';
import 'package:gulf_sky_provider/features/domain/usecases/auth/change_fcm_token_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/auth/login_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/auth/register_usecase.dart';

import '../../../core/api/api_result.dart';
import '../../../core/api/api_services.dart';

abstract class AuthDataSource {
  Future<Either<Failure, AuthResponseModel>> login(LoginParameters parameters);

  Future<Either<Failure, AuthResponseModel>> changeFCMToken(ChangeFCMTokenParameters parameters);

  Future<Either<Failure, AuthResponseModel>> register(RegisterParameters parameters);
}

class AuthDataSourceImpl extends AuthDataSource {
  final ApiService _apiService;

  AuthDataSourceImpl(this._apiService);

  @override
  Future<Either<Failure, AuthResponseModel>> login(LoginParameters parameters) async {
    ApiResult result = await _apiService.post(
        endPoint: URLs.login,
        data: FormData.fromMap(
          {
            'username': parameters.username,
            'password': parameters.password,
          },
        ),
        options: DioUtils.getOptions(
          accept: true,
          contentType: true,
          contentTypeString: 'multipart/form-data',
        ));
    if (result.type == ApiResultType.success) {
      return right(AuthResponseModel.fromMap(result.data));
    } else {
      return left(Failure(message: result.message));
    }
  }

  @override
  Future<Either<Failure, AuthResponseModel>> changeFCMToken(ChangeFCMTokenParameters parameters) async {
    ApiResult result = await _apiService.post(
        endPoint: URLs.changeFCMToken,
        data: FormData.fromMap(
          {
            'fcm_token': parameters.fcmToken,
          },
        ),
        options: DioUtils.getOptions(
          accept: true,
          withToken: true,
          contentType: true,
        ));
    if (result.type == ApiResultType.success) {
      return right(AuthResponseModel.fromMap(result.data));
    } else {
      return left(Failure(message: result.message));
    }
  }

  @override
  Future<Either<Failure, AuthResponseModel>> register(RegisterParameters parameters) async {
    MultipartFile? imageMultipart;
    if (parameters.image?.path != null){
      imageMultipart = await MultipartFile.fromFile(
        parameters.image!.path,
      );
    }
    ApiResult result = await _apiService.post(
        endPoint: URLs.register,
        data: FormData.fromMap(
          {
            'email': parameters.email,
            'username': parameters.username,
            'password': parameters.password,
            'address': parameters.address,
            'mobile': parameters.mobile,
            'name': parameters.name,
            'phone': parameters.phone,
            if (imageMultipart != null) 'image': imageMultipart,
          },
        ),
        options: DioUtils.getOptions(
          accept: true,
          contentType: true,
        ));
    if (result.type == ApiResultType.success) {
      return right(AuthResponseModel.fromMap(result.data));
    } else {
      return left(Failure(message: result.message));
    }
  }
}
