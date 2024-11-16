base class ApiException implements Exception {
  final String? message;

  const ApiException({this.message});

  @override
  String toString() => "$runtimeType(message: $message)";
}

base class TimeoutException extends ApiException {
  const TimeoutException({super.message});
}

base class InternetConnectionException extends ApiException {
  const InternetConnectionException({super.message});
}

base class TokenExpiredException extends ApiException {
  const TokenExpiredException({super.message});
}

base class UnauthorizedException extends ApiException {
  const UnauthorizedException({super.message});
}

base class ApiResponseException extends ApiException {
  final int statusCode;
  final List<Map<String, dynamic>>? errors;
  final MessageModel? data;

  //final String? result;

  const ApiResponseException({
    required this.statusCode,
    super.message,
    this.errors,
    this.data,
    //this.result,
  });

  factory ApiResponseException.fromJson(Map<String, dynamic> json) {
    return ApiResponseException(
        statusCode: json['status_code'] as int,
        message: json['message'] as String?,
        errors: json['errors'] as List<Map<String, dynamic>>?,
        data : json['data'] as MessageModel,
      // result: json['result'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status_code': statusCode,
      'message': message,
      'errors': errors,
      'data':data,
      //'result': result,
    };
  }

  @override
  String toString() =>
      "$runtimeType(statusCode: $statusCode, message: $message, errors: $errors,data:${data?.error})";

  ApiResponseException copyWith({
    int? statusCode,
    String? message,
    List<Map<String, dynamic>>? errors,
    String? result,
    MessageModel? data,
  }) {
    return ApiResponseException(
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      errors: errors ?? this.errors,
      data: data ?? this.data,
      //result: result ?? this.result,
    );
  }
}

class MessageModel {
  final String error;

  MessageModel({required this.error});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(

      error: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
    };
  }

  @override
  String toString() => "$runtimeType( message: $error)";

  MessageModel copyWith({

    String? error,

  }) {
    return MessageModel(

      error: error ?? this.error,

    );
  }
}