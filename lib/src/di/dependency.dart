import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:event_bus/event_bus.dart';
import 'package:fanofa/src/environment/environment.dart';
import 'package:fanofa/src/util/firebase_helper.dart';
import 'package:fanofa/src/util/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'mixin.dart';

export 'extension.dart';
export 'mixin.dart';

class Singletons with SingletonsMixin {
  final GetIt _getItInstance;

  static final Singletons I = Singletons(GetIt.asNewInstance());

  Singletons(GetIt getIt) : _getItInstance = getIt;

  Future<void> initDependencies() async {
    _getItInstance
      ..registerSingleton(RouteObserver())
      ..registerLazySingleton<Environment>(const EnvironmentSelector())
      ..registerSingleton<EventBus>(EventBus())
      ..registerSingleton<FirebaseHelper>(FirebaseHelper())
      ..registerSingleton(NotificationHelper());
    await configureData(_getItInstance);
  }

  GetIt get instance => _getItInstance;

  RouteObserver get routeObserver => _getItInstance<RouteObserver>();
}
