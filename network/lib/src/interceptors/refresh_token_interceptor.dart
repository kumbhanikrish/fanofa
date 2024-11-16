import 'dart:io' as io;

import 'package:dio/dio.dart';
import 'package:network/src/exception.dart';
import 'package:network/src/utils/log_mixin.dart';
import 'package:network/src/utils/token_parsing_helper.dart';

import 'interceptors.dart';

class RefreshTokenInterceptor extends QueuedInterceptor with LogMixin {
  final Dio _refreshDio;
  final String refreshTokenUrl;
  final TokenDataCallback onNewTokenData;
  final GetTokenCallback getRefreshToken;
  final GetTokenCallback getAccessToken;

  RefreshTokenInterceptor({
    required this.refreshTokenUrl,
    required this.onNewTokenData,
    required this.getRefreshToken,
    required this.getAccessToken,
    required Dio refreshDio,
  }) : _refreshDio = refreshDio;

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.badResponse && err.response?.statusCode == 401 && (getRefreshToken() != null && getRefreshToken()!.isNotEmpty)) {
      try {
        await _refreshToken();
        return handler.reject(DioException(
          type: DioExceptionType.unknown,
          requestOptions: err.requestOptions,
          error: const TokenExpiredException(),
        ));
      } on DioException catch (dioError) {
        return handler.next(dioError);
      } catch (error) {
        return handler.reject(DioException(
          type: DioExceptionType.unknown,
          requestOptions: err.requestOptions,
          error: error,
        ));
      }
    }
    handler.next(err);
  }

  Future<void> _refreshToken() async {
    try {
      Response response = await _refreshDio.post(
        refreshTokenUrl,
        options: Options(headers: {io.HttpHeaders.authorizationHeader: "Bearer ${getAccessToken()}"}),
        data: {
          "refresh_token": getRefreshToken(),
        },
      );
      final tokenData = parseTokenData(response);
      if (tokenData == null) {
        throw const ApiException(message: '[accessToken] and [refreshToken] should be provided in cookie');
      } else {
        onNewTokenData(tokenData);
      }
    } on DioException catch (error) {
      if (error.type == DioExceptionType.badResponse && error.response?.statusCode == 422) return;
      rethrow;
    }
  }
}
