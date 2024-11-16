import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:network/network.dart';

abstract class BaseBloc<E extends Object?, S extends Object?> extends Bloc<E, S>
    with StreamSubscriptionMixin, ListMixin, ApiMixin, LoadingMixin {
  @override
  final BuildContext context;

  BaseBloc(this.context, super.initialState) {
    Timer.run(onCreate);
  }

  @protected
  @mustCallSuper
  void onCreate() {}

  @protected
  @override
  void handleLoader(bool isLoading) {
    handleLoading(isLoading);
  }

  @override
  StreamSubscription<DataEvent<T>> processData<T>(
    Stream<DataEvent<T>> stream, {
    bool handleLoading = true,
    required ResultCallback<T>? onSuccess,
    LoadingCallback? onLoading,
    ApiExceptionCallback? onFailure,
  }) {
    final subscription = super.processData(
      stream,
      handleLoading: handleLoading,
      onLoading: onLoading,
      onSuccess: onSuccess,
      onFailure: onFailure,
    );
    listSubscription.add(subscription);
    return subscription;
  }
}
