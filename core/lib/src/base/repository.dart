
/*
import 'dart:io' as io;

import 'package:core/src/helpers/helpers.dart';
import 'package:dio/dio.dart';
import 'package:network/network.dart';

abstract class BaseRepository {
  final Dio dio;
  final CacheService? cacheService;

  BaseRepository({required this.dio, this.cacheService});

  String? get baseUrl => null;

  Stream<DataEvent<T>> processApi<T>(ApiRequest<T> request,
      {bool fromCache = true}) async* {
    yield DataEvent<T>.loading(true);
    if (cacheService != null &&
        request.requestType == RequestType.get &&
        fromCache) {
      yield* _getResponseFromCache(request);
    }
    yield* _getResponse(request);
  }

  Stream<DataEvent<T>> _getResponseFromCache<T>(ApiRequest<T> request) async* {
    try {
      var cache = await cacheService?.get(request.cacheKey);
      if (cache != null) {
        if (cache.isValid) {
          var data = request.responseParser?.call(cache.data) ?? cache.data;
          yield DataEvent<T>.loading(false);
          yield DataEvent<T>.success(data, isCache: true);
        } else {
          cacheService?.remove(request.cacheKey);
        }
      }
    } catch (error, stackTrace) {
      Log.debug(error);
      Log.debug(stackTrace);
    }
  }

  Stream<DataEvent<T>> _getResponse<T>(ApiRequest<T> request) async* {
    try {
      var response = await request.fetch(dio, baseUrl: baseUrl);
      _saveCacheResponse(request, response);
      yield DataEvent<T>.loading(false);
      yield DataEvent<T>.success(response.data,
          statusCode: response.statusCode);
    } on DioError catch (dioError) {
      yield DataEvent<T>.loading(false);
      if (dioError.error is TokenExpiredException) {
        yield* processApi(request);
      } else if (dioError.error is io.SocketException) {
        yield DataEvent<T>.failure(const InternetConnectionException());
      } else {
        var apiException = _handleDioError(dioError);
        if (apiException != null) yield DataEvent<T>.failure(apiException);
      }
    } on io.SocketException catch (error, stacktrace) {
      yield DataEvent<T>.loading(false);
      yield DataEvent<T>.failure(const InternetConnectionException());
      error.error();
      stacktrace.error();
    } catch (error, stacktrace) {
      yield DataEvent<T>.loading(false);
      error.error();
      stacktrace.error();
    }
  }

  Future<void> _saveCacheResponse(ApiRequest request, dynamic response) async {
    if (request.requestType == RequestType.get) {
      cacheService?.set(request.cacheKey,
          CachedResponse(data: response, createAt: DateTime.now()));
    }
  }

  ApiException? _handleDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        return const TimeoutException();
      case DioErrorType.badResponse:
        return _handleResponseError(dioError);
      case DioErrorType.unknown:
        throw dioError;
      case DioErrorType.cancel:
        break;
      case DioErrorType.badCertificate:
        break;
      case DioErrorType.connectionError:
        break;
    }
    return null;
  }

  ApiResponseException _handleResponseError(DioError dioError) {
    String? message;
    Map<String, dynamic>? errors;
    final responseData = dioError.response?.data;
    if (responseData is Map<String, dynamic>) {
      if (responseData['message'] is String) message = responseData['message'];
      if (responseData['errors'] is Map<String, dynamic>)
        errors = responseData['errors'];
    }
    return ApiResponseException(
        statusCode: dioError.response?.statusCode ?? -1,
        message: message,
        errors: errors);
  }
}
*/