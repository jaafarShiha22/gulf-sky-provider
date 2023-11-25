import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gulf_sky_provider/core/api/urls.dart';
import 'package:gulf_sky_provider/core/error/failure.dart';
import 'package:gulf_sky_provider/core/utils/dio_utils.dart';
import 'package:gulf_sky_provider/features/data/models/package/package_model.dart';
import 'package:gulf_sky_provider/features/domain/usecases/packages/unsubscribe_package_usecase.dart';

import '../../../core/api/api_result.dart';
import '../../../core/api/api_services.dart';
import '../../domain/usecases/packages/subscribe_package_usecase.dart';
import '../models/package/subscribed_package_model.dart';

abstract class PackagesDataSource {
  Future<Either<Failure, List<PackageModel>>> getPackages();

  Future<Either<Failure, SubscribedPackageModel>> subscribePackage(SubscribePackageParameters parameters);

  Future<Either<Failure, void>> unsubscribePackage(UnsubscribePackageParameters parameters);
}

class PackagesDataSourceImpl extends PackagesDataSource {
  final ApiService _apiService;

  PackagesDataSourceImpl(this._apiService);

  @override
  Future<Either<Failure, List<PackageModel>>> getPackages() async {
    ApiResult result = await _apiService.post(
        endPoint: URLs.getPackages,
        data: FormData.fromMap({}),
        options: DioUtils.getOptions(
          accept: true,
          contentType: true,
        ));
    try {
      if (result.type == ApiResultType.success) {
        return right((result.data as List)
            .map(
              (packageModel) => PackageModel.fromMap(packageModel),
            )
            .toList());
      } else {
        return left(Failure(message: result.message));
      }
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SubscribedPackageModel>> subscribePackage(SubscribePackageParameters parameters) async {
    ApiResult result = await _apiService.post(
        endPoint: URLs.subscribePackage,
        data: FormData.fromMap({'package_id': parameters.packageId}),
        options: DioUtils.getOptions(
          accept: true,
          withToken: true,
          contentType: true,
        ));
    try {
      if (result.type == ApiResultType.success) {
        return right(SubscribedPackageModel.fromMap(result.data));
      } else {
        return left(Failure(message: result.message));
      }
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unsubscribePackage(UnsubscribePackageParameters parameters) async {
    ApiResult result = await _apiService.post(
        endPoint: parameters.isPackagePaid ? URLs.cancelContract : URLs.unsubscribePackage,
        data: FormData.fromMap(
          parameters.isPackagePaid ?{'contract_id': parameters.packageId} : {'package_id': parameters.packageId},
        ),
        options: DioUtils.getOptions(
          accept: true,
          withToken: true,
          contentType: true,
        ));
    try {
      if (result.type == ApiResultType.success) {
        return right(null);
      } else {
        return left(Failure(message: result.message));
      }
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
