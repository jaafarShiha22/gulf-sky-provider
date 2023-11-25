import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gulf_sky_provider/features/domain/entities/auth/auth_response_entity.dart';


class DioUtils {
  static Options getOptions(
      {bool all = false,
      bool contentType = false,
      String contentTypeString = 'application/json',
      bool accept = false,
      bool acceptLanguage = false,
      bool withLocalization = false,
      bool withToken = false}) {
    Options options = Options(
      headers: {},
      validateStatus: (status) => true,
      sendTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10)
    );

    if (contentType || all) {
      options.contentType = contentTypeString;
    }
    if (accept || all) {
      options.headers?.addAll({'accept': 'application/json'});
    }
    if (withLocalization || all) {
      options.headers?.addAll({'X-localization': 'en'});
    }
    if (acceptLanguage || all) {
      options.headers?.addAll({'Accept-Language': 'en, ar'});
    }
    if (withToken || all) {
      options.headers?.addAll({"Authorization": "Bearer ${GetIt.instance.get<AuthResponseEntity>().token}"});
    }
    return options;
  }
}
