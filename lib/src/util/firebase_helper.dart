import 'dart:async';
import 'dart:convert';
import 'package:core/core.dart';
import 'package:fanofa/src/util/permission/permission_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:retry/retry.dart';
import 'package:data/src/pref/app_pref.dart';

import '../di/dependency.dart';

class FirebaseHelper {
  FirebaseHelper();

  late final FirebaseMessaging _messaging = FirebaseMessaging.instance;

// Save an integer value to 'counter' key.

  Future<void> initializeApp() async {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey:
            "AIzaSyCDvXhdYYX-GBZ5yaGmzwCDUuDPSZWy0mg", // paste your api key here
        appId:
            "1:1020008299101:android:6a533972608fa3f727ebb4", //paste your app id here
        messagingSenderId: "1020008299101", //paste your messagingSenderId here
        projectId: "ghansyamcake", //paste your project id here
      ),
    );
    getToken().then((fcmTokenValue) async {
      Singletons.I.pref.fcmToken = fcmTokenValue;
      print('LoginRequest-1 ${Singletons.I.pref.fcmToken }');
    });
    // SharedPreferences.
    await setupFlutterNotifications();
    await methodNotification();
    // FirebaseMessaging.instance.subscribeToTopic('ClusterTopic');
  }

  Future getToken() {
    return retry(
      _messaging.getToken,
      retryIf: (exception) => exception is PlatformException,
      maxAttempts: 3,
      delayFactor: const Duration(milliseconds: 100),
    ).onError((error, stackTrace) {
      "FirebaseHelper.token -> $error".error();
      return null;
    });
  }

  Future<void> deleteToken() {
    return _messaging.deleteToken();
  }

  /* Future<void> setCrashlyticsCollectionEnabled([bool enabled = true]) =>
      FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(enabled);

  Future<void> recordFlutterError(FlutterErrorDetails errorDetails) =>
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);

  Future<void> recordError(dynamic error, StackTrace stackTrace) =>
      FirebaseCrashlytics.instance.recordError(error, stackTrace);*/

  Future<RemoteMessage?> getInitialMessage() => _messaging.getInitialMessage();

  StreamSubscription<RemoteMessage> onMessage(
          void Function(RemoteMessage message) listener) =>
      FirebaseMessaging.onMessage.listen(listener);

  StreamSubscription<RemoteMessage> onMessageOpenedApp(
          void Function(RemoteMessage message) listener) =>
      FirebaseMessaging.onMessageOpenedApp.listen(listener);

  late final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final StreamController<NotificationResponse> _streamController =
      StreamController<NotificationResponse>.broadcast();

  Stream<NotificationResponse> get onDidReceiveNotificationResponse =>
      _streamController.stream;

  static const _categoryGeneralNotification = "cluster-sort-mobile";
  static const _androidNotificationIcon = "splash_screen";

  Future<void> setupFlutterNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings(_androidNotificationIcon);
    const DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings(defaultPresentBadge: true);
    const iosSettings = darwinInitializationSettings;
    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);
    await _notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onLocalNotificationClick);
  }

  Future<bool> resolveNotificationPermission(BuildContext context) async {
    final permissionHelper = PermissionHelper.notification(context);
    final hasPermission = await permissionHelper.checkPermission();
    return hasPermission;
  }

  Future<void> resolvePlatformImplementation() async {
    _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(const AndroidNotificationChannel(
            _categoryGeneralNotification, "General Notifications"));
  }

  void showNotification({
    required Map<String, dynamic> data,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('channel_id', 'channel_name',
            channelDescription: 'channel_description',
            importance: Importance.high,
            priority: Priority.high,
            icon: _androidNotificationIcon);
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(sound: 'slow_spring_board.aiff');
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: darwinNotificationDetails,
    );
    print('data :::::::$data');

    await _notificationsPlugin.show(
      0,
      data['title'],
      data['body'],
      platformChannelSpecifics,
      payload: jsonEncode(data['data']),
    );

    // FBroadcast.instance().broadcast(
    //   "BROADCAST_REQUESTED",
    //   value: jsonEncode(data['data']),
    // );
  }

  Future<void> methodNotification() async {
    FirebaseMessaging.instance.requestPermission();
    Map<String, dynamic>? notificationResponse;
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    await getToken();
    //  final SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseMessaging.instance.onTokenRefresh.listen(
      (fcmToken) {
        Singletons.I.pref.fcmToken = fcmToken;
        print('LoginRequest-1 $fcmToken');
        // Note: This callback is fired at each app startup and whenever a new
        // token is generated.
      },
    ).onError(
      (err) {
        print("FCM ERROR:::: $err");
        // Error getting token.
      },
    );
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage remoteMessage) {
        debugPrint('Data Message Received');
        notificationResponse = {
          'title': remoteMessage.notification!.title,
          'body': remoteMessage.notification!.body,
          'data': remoteMessage.data,
        };
        print('remoteMessage.notification! :::::::${remoteMessage.data}');
        showNotification(
          data: notificationResponse!,
        );
        //Fcm Navigation Service Provider for Screen Navigation
        // ref
        //     .watch(fcmNavigationProvider)
        //     .navigationFunction(notificationResponse);
        if (remoteMessage.notification != null) {
          debugPrint(
              'Message notification: ${remoteMessage.notification!.title} ${remoteMessage.notification!.body} ${remoteMessage.data}');
        }
      },
    );
  }

  void onLocalNotificationClick(NotificationResponse details) {
    debugPrint(
        "_onDidReceiveNotificationResponse -> $details -> ${details.payload}");
    _streamController.add(details);
    if (details.payload != null) {
      print("onLocalNotificationClick===payload==${details.payload}");
      PushNotificationDataModel notificationModel =
          PushNotificationDataModel.fromJson(jsonDecode(details.payload!));
      print(
          "onLocalNotificationClick===notificationModel==${notificationModel.woId}");
    }
  }

  Future<void> getAppLaunchDetails() async {
    final details =
        await _notificationsPlugin.getNotificationAppLaunchDetails();
    if (details == null) return;
    if (details.didNotificationLaunchApp &&
        details.notificationResponse != null) {
      _streamController.add(details.notificationResponse!);
    }
  }

  Future<void> backGroundOnClickEvent({BuildContext? context}) async {
    ////this method is for when app is killed
    FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? message) {
        print('getInitialMessage BG NOTIFICATION RECEIVED :::::::::$message');
        // if (message?.data != null && message!.data['woId'] != null && message.data['woId'].toString().isNotEmpty) {
        //   handleNotificationData(woId: message!.data['woId'].toString(), context: context!);
        // }
      },
    );
    FirebaseMessaging.onMessageOpenedApp
        .listen((RemoteMessage? message) {})
        .onData((message) {
      print(
          'onMessageOpenedApp BG NOTIFICATION RECEIVED :::::::::${message.data['woId']}');
    });
  }
}

class PushNotificationDataModel {
  String? woId;

  PushNotificationDataModel({this.woId});

  PushNotificationDataModel.fromJson(Map<String, dynamic> json) {
    woId = json['woId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['woId'] = this.woId;
    return data;
  }
}
