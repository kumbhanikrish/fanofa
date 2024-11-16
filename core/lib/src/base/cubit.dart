import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/src/base/state.dart';
import 'package:core/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:network/network.dart';

abstract class BaseCubit<S extends Object?> extends Cubit<S> with StreamSubscriptionMixin, ListMixin, ApiMixin, LoadingMixin {
  @override
  final BuildContext context;

  BaseCubit(this.context, super.initialState) {
    Timer.run(onCreate);
  }



  @protected
  @mustCallSuper
  void onCreate() {}

  @protected
  @override
  void handleLoader(bool isLoading) => handleLoading(isLoading);

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

abstract class DataCubit<S extends DataState> extends BaseCubit<S> {
  DataCubit(super.context, super.initialState);

  @mustCallSuper
  Future<void> onRefresh() async {
    if (state.isLoading) return;
    return fetchData();
  }

  Future<void> fetchData();
}

abstract class ListCubit<S extends ListState> extends BaseCubit<S> {
  ListCubit(super.context, super.initialState);

  Future<void> fetchList();
}

abstract class PaginatedListCubit<S extends PaginatedListState<T>, T extends Object?> extends ListCubit<S> {
  PaginatedListCubit(super.context, super.initialState);

  @mustCallSuper
  bool onScrollNotification(UserScrollNotification notification) {
    if (notification.metrics.pixels >= notification.metrics.maxScrollExtent) onScrollToEnd();
    return false;
  }

  @mustCallSuper
  Future<void> onScrollToEnd() async {
    if (state.isLoading || state.reachAtEnd) return;
    emit(state.copyWith(isLoading: true) as S);
    onLoadMore();
  }

  @mustCallSuper
  Future<void> onRefresh() async {
    if (state.isLoading) return;
    emit(state.copyWith(reachAtEnd: false, list: <T>[]) as S);
    return fetchList();
  }

  Future<void> onLoadMore() => fetchList();
}
