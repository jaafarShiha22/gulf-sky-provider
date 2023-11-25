import 'dart:io';

import 'package:dio/dio.dart' as dio;

enum NetworkException {
  requestCancelled,
  unauthorisedRequest,
  badRequest,
  notFound,
  methodNotAllowed,
  notAcceptable,
  requestTimeout,
  sendTimeout,
  badCertificate,
  conflict,
  internalServerError,
  notImplemented,
  serviceUnavailable,
  noInternetConnection,
  formatException,
  unableToProcess,
  defaultError,
  unexpectedError,
  unKnown,
}

class NetworkExceptions {
  final NetworkException networkException;
  final String? error;

  NetworkExceptions(this.networkException, {this.error});

  factory NetworkExceptions.requestCancelled() =>
      NetworkExceptions(NetworkException.requestCancelled);

  factory NetworkExceptions.unauthorisedRequest() =>
      NetworkExceptions(NetworkException.unauthorisedRequest);

  factory NetworkExceptions.badRequest() =>
      NetworkExceptions(NetworkException.badRequest);

  factory NetworkExceptions.notFound(String error) =>
      NetworkExceptions(NetworkException.notFound, error: error);

  factory NetworkExceptions.methodNotAllowed() =>
      NetworkExceptions(NetworkException.methodNotAllowed);

  factory NetworkExceptions.notAcceptable() =>
      NetworkExceptions(NetworkException.notAcceptable);

  factory NetworkExceptions.requestTimeout() =>
      NetworkExceptions(NetworkException.requestTimeout);

  factory NetworkExceptions.sendTimeout() =>
      NetworkExceptions(NetworkException.sendTimeout);

  factory NetworkExceptions.badCertificate() =>
      NetworkExceptions(NetworkException.badCertificate);

  factory NetworkExceptions.conflict() =>
      NetworkExceptions(NetworkException.conflict);

  factory NetworkExceptions.internalServerError() =>
      NetworkExceptions(NetworkException.internalServerError);

  factory NetworkExceptions.notImplemented() =>
      NetworkExceptions(NetworkException.notImplemented);

  factory NetworkExceptions.serviceUnavailable() =>
      NetworkExceptions(NetworkException.serviceUnavailable);

  factory NetworkExceptions.noInternetConnection() =>
      NetworkExceptions(NetworkException.noInternetConnection);

  factory NetworkExceptions.unKnown() =>
      NetworkExceptions(NetworkException.unKnown);

  factory NetworkExceptions.formatException() =>
      NetworkExceptions(NetworkException.formatException);

  factory NetworkExceptions.unableToProcess() =>
      NetworkExceptions(NetworkException.unableToProcess);

  factory NetworkExceptions.unexpectedError() =>
      NetworkExceptions(NetworkException.unexpectedError);

  factory NetworkExceptions.defaultError(String error) =>
      NetworkExceptions(NetworkException.defaultError, error: error);

  static NetworkExceptions getDioException(error) {
    if (error is Exception) {
      try {
        late NetworkExceptions networkExceptions;
        if (error is dio.DioError) {
          switch (error.type) {
            case dio.DioErrorType.cancel:
              networkExceptions = NetworkExceptions.requestCancelled();
              break;
            case dio.DioErrorType.connectionTimeout:
              networkExceptions = NetworkExceptions.requestTimeout();
              break;
            case dio.DioErrorType.receiveTimeout:
              networkExceptions = NetworkExceptions.sendTimeout();
              break;
            case dio.DioErrorType.badCertificate:
              networkExceptions = NetworkExceptions.badCertificate();
              break;
            case dio.DioErrorType.badResponse:
              switch (error.response!.statusCode) {
                case 400:
                  networkExceptions = NetworkExceptions.unauthorisedRequest();
                  break;
                case 401:
                  networkExceptions = NetworkExceptions.unauthorisedRequest();
                  break;
                case 403:
                  networkExceptions = NetworkExceptions.unauthorisedRequest();
                  break;
                case 404:
                  networkExceptions = NetworkExceptions.notFound("Not found");
                  break;
                case 409:
                  networkExceptions = NetworkExceptions.conflict();
                  break;
                case 408:
                  networkExceptions = NetworkExceptions.requestTimeout();
                  break;
                case 500:
                  networkExceptions = NetworkExceptions.internalServerError();
                  break;
                case 503:
                  networkExceptions = NetworkExceptions.serviceUnavailable();
                  break;
                default:
                  var responseCode = error.response!.statusCode;
                  networkExceptions = NetworkExceptions.defaultError(
                    "Received invalid status code: $responseCode",
                  );
              }
              break;
            case dio.DioErrorType.sendTimeout:
              networkExceptions = NetworkExceptions.sendTimeout();
              break;
            case dio.DioErrorType.connectionError:
              networkExceptions = NetworkExceptions.noInternetConnection();
              break;
            case dio.DioErrorType.unknown:
              networkExceptions = NetworkExceptions.unKnown();
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException catch (_) {
        return NetworkExceptions.formatException();
      } catch (_) {
        return NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return NetworkExceptions.unableToProcess();
      } else {
        return NetworkExceptions.unexpectedError();
      }
    }
  }

  static String getErrorMessage(error) {
    NetworkExceptions networkException =
        NetworkExceptions.getDioException(error);
    return _getMessage(networkException);
  }

  static String _getMessage(NetworkExceptions networkException) {
    String errorMessage = "";
    switch (networkException.networkException) {
      case NetworkException.notImplemented:
        errorMessage = "Not Implemented";
        break;
      case NetworkException.requestCancelled:
        errorMessage = "Request Cancelled";
        break;
      case NetworkException.internalServerError:
        errorMessage = "Internal Server Error";
        break;
      case NetworkException.notFound:
        errorMessage = networkException.error??'';
        break;
      case NetworkException.serviceUnavailable:
        errorMessage = "Service unavailable";
        break;
      case NetworkException.methodNotAllowed:
        errorMessage = "Method Allowed";
        break;
      case NetworkException.badRequest:
        errorMessage = "Bad request";
        break;
      case NetworkException.unauthorisedRequest:
        errorMessage = "Unauthorised request";
        break;
      case NetworkException.unexpectedError:
        errorMessage = "Unexpected error occurred";
        break;
      case NetworkException.requestTimeout:
        errorMessage = "Connection request timeout";
        break;
      case NetworkException.noInternetConnection:
        errorMessage = "No internet connection";
        break;
      case NetworkException.conflict:
        errorMessage = "Error due to a conflict";
        break;
      case NetworkException.sendTimeout:
        errorMessage = "Send timeout in connection with API server";
        break;
      case NetworkException.unableToProcess:
        errorMessage = "Unable to process the data";
        break;

      case NetworkException.formatException:
        errorMessage = "Unexpected error occurred";
        break;

      case NetworkException.notAcceptable:
        errorMessage = "Not acceptable";
        break;
      case NetworkException.defaultError:
        errorMessage = networkException.error??'';
        break;
      case NetworkException.badCertificate:
        errorMessage = "Bad certificate";
        break;
      case NetworkException.unKnown:
        errorMessage = "Unknown";
        break;
    }
    return errorMessage;
  }
}
