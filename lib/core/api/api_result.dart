import 'default_response.dart';
import 'error_response.dart';

enum ApiResultType { success, failure }

abstract class ApiResult<T> {
  late ApiResultType type;
  late T data;
  late String message;
  List<dynamic>? errors;

  factory ApiResult.success(T data, String message) => DefaultResponse<T>(
        data: data,
        message: message,
        success: true,
      );

  factory ApiResult.successFromJson(Map<String, dynamic> json) => DefaultResponse<T>(
        data: json["data"] ?? [],
        success: json["success"] ?? json["success"],
        message: json["message"] ?? json["message"],
      );

  factory ApiResult.failure(String error) => ErrorResponse(
        message: error,

      );

  //factory ApiResult.failure(String error,{Map<String,String> errors}) => ErrorResponse<T>(message: error,errors: errors);

  factory ApiResult.failureFromJson(Map<String, dynamic> jsonFrom) => ErrorResponse<T>(
        errors: jsonFrom["errors"],
        success: jsonFrom["success"],
        message: jsonFrom["message"],
      );
}
