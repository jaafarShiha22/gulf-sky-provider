import 'dart:convert';

import 'api_result.dart';


class DefaultResponse<T> with ApiResult<T> {
  DefaultResponse({
    required data,
    required this.success,
    required message,
  }) {
    super.type = ApiResultType.success;
    super.data = data;
    super.message = message;
  }

  // final T data;
  final bool success;
  // final String message;

  factory DefaultResponse.fromRawJson(String str) => DefaultResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DefaultResponse.fromJson(Map<String, dynamic> json) => DefaultResponse(
        data: json["data"] ?? json["data"],
        success: json["success"] ?? json["success"],
        message: json["message"] ?? json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "success": success,
        "message": message,
      };
}
