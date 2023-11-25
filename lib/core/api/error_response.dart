import 'dart:convert';

import 'api_result.dart';

class ErrorResponse<T> with ApiResult<T> {
  // final List<dynamic>? errors;
  final bool? success;
  // late final String message;

  ErrorResponse({
    errors,
    this.success = false,
    required message,
  }) {
    super.type = ApiResultType.failure;
    super.message = message;
    super.errors = errors;
  }

  factory ErrorResponse.fromRawJson(String str) => ErrorResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ErrorResponse.fromJson(Map<String, dynamic> jsonFrom) => ErrorResponse(
        errors: jsonFrom["errors"] == null ? null : jsonFrom['errors'],
        success: jsonFrom["success"] ?? jsonFrom["success"],
        message: jsonFrom["message"] ?? jsonFrom["message"],
      );

  Map<String, dynamic> toJson() => {
        "errors": errors,
        "success": success,
        "message": message,
      };
}
