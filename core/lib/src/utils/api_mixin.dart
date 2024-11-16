import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:network/network.dart';

import '../helpers/connectivity_helper.dart';

typedef ResultCallback<T> = void Function(T data);
typedef LoadingCallback = void Function(bool isLoading);
typedef ApiExceptionCallback = void Function(ApiException exception);

mixin ApiMixin<S extends Object?> on BlocBase<S> {
  final ConnectivityHelper connectivityHelper = ConnectivityHelper();
  int _loaderCount = 0;

  @override
  Future<void> close() {
    if (_loaderCount > 0) handleLoader(false);
    return super.close();
  }

  @mustCallSuper
  @protected
  StreamSubscription<DataEvent<T>> processData<T>(
    Stream<DataEvent<T>> stream, {
    bool handleLoading = true,
    required ResultCallback<T>? onSuccess,
    LoadingCallback? onLoading,
    ApiExceptionCallback? onFailure,
  }) {
    if (!connectivityHelper.hasInternet) onApiExceptions(const InternetConnectionException());
    return stream.listen((event) {
      if (event is LoadingEvent<T> && handleLoading) return (onLoading ?? _handleLoader)(event.isLoading);
      if (event is SuccessEvent<T>) return onSuccess?.call(event.data);
      if (event is FailureEvent<T>) return (onFailure ?? handleApiExceptions)(event.exception);
    });
  }

  /// handles show/dismiss of loading dialog
  void _handleLoader(bool isLoading) {
    if (isLoading) {
      if (_loaderCount == 0) handleLoader(isLoading);
      _loaderCount++;
    } else {
      _loaderCount = max(0, _loaderCount - 1);
      if (_loaderCount == 0) handleLoader(isLoading);
    }
  }

  void handleApiExceptions(ApiException exception) {
    if (exception is ApiResponseException) {
      final newException = _handleResponseError(exception);
      if (newException != null) exception = newException;
    }
    onApiExceptions(exception);
  }

  ApiException? _handleResponseError(ApiResponseException exception) {
      print("This is exception code ${exception.statusCode}");
    switch (exception.statusCode) {
      case HttpStatus.internalServerError:
      case HttpStatus.badRequest:
      case HttpStatus.forbidden:
      case HttpStatus.notFound:
      case HttpStatus.conflict:
      case HttpStatus.locked:
      case HttpStatus.paymentRequired:
      case HttpStatus.unprocessableEntity:
        return exception;
      case HttpStatus.unauthorized:
        return const UnauthorizedException();
    }
    return null;
  }

  void handleLoader(bool isLoading);

    void onApiExceptions(ApiException exception) {
      addError(exception);
    }
}
