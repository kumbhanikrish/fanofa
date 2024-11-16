import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:event_bus/event_bus.dart';
import 'package:fanofa/src/util/firebase_helper.dart';
import 'package:fanofa/src/util/notification_helper.dart';




import 'dependency.dart';

mixin SingletonsMixin {
  Environment get environment => Singletons.I<Environment>();

  AppPref get pref => Singletons.I<AppPref>();

  EventBus get eventBus => Singletons.I<EventBus>();

  FirebaseHelper get firebaseHelper => Singletons.I<FirebaseHelper>();

  NotificationHelper get notificationHelper => Singletons.I<NotificationHelper>();

  T call<T extends Object>() => Singletons.I.instance<T>();
}
