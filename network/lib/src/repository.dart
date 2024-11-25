import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;

import 'package:dio/dio.dart';
import 'package:network/network.dart';

import 'utils/log_mixin.dart';

abstract class BaseRepository with LogMixin {
  final Dio dio;
  final CacheService? cacheService;
  final Duration cacheValidity = const Duration(days: 7);
  final String? baseUrl;

  BaseRepository({
    required this.dio,
    this.cacheService,
    this.baseUrl,
  });

  Stream<DataEvent<T>> processApi<T>(ApiRequest<T> request, {bool fromCache = true}) async* {
    yield const LoadingEvent(true);
    if (cacheService != null && fromCache) {
      final cachedResponse = await _getResponseFromCache(request);
      if (cachedResponse != null) {
        yield const LoadingEvent(false);
        yield SuccessEvent(cachedResponse.data, statusCode: cachedResponse.statusCode, isCache: true);
      }
    }
    yield* _getResponseFromNetwork(request);
  }

  Future<({T data, int? statusCode})?> _getResponseFromCache<T>(ApiRequest<T> request) async {
    if (request.requestType != RequestType.get) return null;
    try {
      var cache = await cacheService?.get(request.cacheKey);
      if (cache != null) {
        if (!cache.createAt.isAfter(DateTime.now().subtract(cacheValidity))) {
          cacheService?.remove(request.cacheKey);
          return null;
        }
        var data = await request.responseParser.call(cache.data);
        return (data: data, statusCode: cache.statusCode);
      }
    } catch (error, stackTrace) {
      printError(error);
      printError(stackTrace);
    }
    return null;
  }

  Future<T> processApiRequest<T>(ApiRequest<T> request, {bool fromCache = true}) async {
    try {
      final result = await request.fetch(dio);
      _saveCacheResponse(request, result);
      return result.data;
    } catch (error, stacktrace) {
      switch (error) {
        case DioException():
          if (error.error is TokenExpiredException) {
            return processApiRequest(request);
          } else if (error.error is io.SocketException || error.error is io.HttpException) {
            InternetConnectionException(message: "Please Check Your Internet connection");
          } else {
            var apiException = handleDioException(error);
            if (apiException != null) throw apiException;
          }
          break;
        case io.SocketException() || io.HttpException():
          InternetConnectionException(message: "Please Check Your Internet connection");
        default:
          printError(error);
          printError(stacktrace);
      }
      rethrow;
    }
  }

  Future<T?> _handleInternetConnectionException<T>(ApiRequest<T> request, Object error) async {
    final cachedResponse = await _getResponseFromCache(request);
    if (cachedResponse != null) return cachedResponse.data;
    throw InternetConnectionException(message: "Please Check Your Internet connection");
  }

  Stream<DataEvent<T>> _getResponseFromNetwork<T>(
    ApiRequest<T> request, {
    CancelToken? cancelToken,
    ProgressCallback? receiveProgress,
    ProgressCallback? sendProgress,
  }) async* {
    try {
      var response = await request.fetch(
        dio,
        baseUrl: baseUrl,
        cancelToken: cancelToken,
        receiveProgress: receiveProgress,
        sendProgress: sendProgress,
      );
      yield const LoadingEvent(false);
      yield SuccessEvent(response.data, statusCode: response.statusCode);
      _saveCacheResponse(request, response);
    } catch (error, stacktrace) {
      yield const LoadingEvent(false);
      switch (error) {
        case DioException():
          if (error.error is TokenExpiredException) {
            yield* processApi(request);
          } else if (error.error is io.SocketException || error.error is io.HttpException) {
            yield FailureEvent(InternetConnectionException(message: "Please Check Your Internet connection"));
          } else {
            var apiException = handleDioException(error);
            if (apiException != null) yield FailureEvent(apiException);
          }
          break;
        case io.SocketException() || io.HttpException():
          yield FailureEvent(InternetConnectionException(message: "Please Check Your Internet connection"));
          break;
        default:
          printError(error);
          printError(stacktrace);
      }
    }
  }

  Future<void> _saveCacheResponse(ApiRequest request, ApiResponse response) async {
    if (request.requestType != RequestType.get) return;
    cacheService?.set(
      request.cacheKey,
      CachedResponse(data: response.response.data, statusCode: response.statusCode, createAt: DateTime.now()),
    );
  }

  ApiException? handleDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return const InternetConnectionException(message: "Please Check Your Internet Connection");
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();
      case DioExceptionType.badResponse:
        if (dioException.response?.statusCode == io.HttpStatus.unauthorized) {
          return const UnauthorizedException();
        } else if (dioException.response?.data != null) {
          return _handleResponseError(dioException);
        }
        break;
      case DioExceptionType.unknown:
        throw dioException;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.badCertificate:
        break;
      case DioExceptionType.connectionError:
        break;
    }
    return null;
  }

  ApiResponseException _handleResponseError(DioException dioException) {
    String? message;
    String? result;
    List<Map<String, dynamic>>? errors;
    final responseData = dioException.response?.data;
    print("responseData :: $responseData");
    if (responseData is Map<String, dynamic>) {
      if (responseData['error'] is String) message = responseData['error'];

      if (responseData['error'] is List) {
        errors = (responseData['error'] as List).map((dynamic item) {
          if (item is Map<String, dynamic>) {
            return Map<String, dynamic>.from(item);
          }
          return <String, dynamic>{};
        }).toList();
      }
     // if (responseData['result'] is String) result = responseData['result'];
    }
    return ApiResponseException(statusCode: dioException.response?.statusCode ?? -1, message: message, /*result: result*/);
  }
}
