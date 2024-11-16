import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:event_bus/event_bus.dart';
import 'package:fanofa/src/util/firebase_helper.dart';
import 'package:fanofa/src/util/notification_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBase;


import 'dependency.dart';

extension $DependencyExtension on BlocBase {
  Environment get environment => Singletons.I.environment;

  AppPref get pref => Singletons.I.pref;

  EventBus get eventBus => Singletons.I.eventBus;

  FirebaseHelper get firebaseHelper => Singletons.I.firebaseHelper;

  NotificationHelper get notificationHelper => Singletons.I<NotificationHelper>();
}
