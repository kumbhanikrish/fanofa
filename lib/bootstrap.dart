
import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:data/data.dart';
import 'package:fanofa/src/app/user/user_cubit.dart';
import 'package:fanofa/src/di/dependency.dart';
import 'package:fanofa/src/logic/theme/theme_cubit.dart';
import 'package:fanofa/src/packages/resouces/resources.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'src/app/localization/localization_cubit.dart';
Future<void> bootstrap(FutureOr<Widget> Function() builder, {required BlocObserver blocObserver}) async {
  return runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    var singletons = Singletons.I;
    await singletons.initDependencies();
    // Initialize [FirebaseApp] and enable crashlytics error collection if not running in debug mode.
    //  final firebaseHelper = singletons<FirebaseHelper>();
    //  await firebaseHelper.initializeApp();

    // await firebaseHelper.setCrashlyticsCollectionEnabled(!kDebugMode);

    Bloc.observer = blocObserver;

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    /* // Record flutter errors in firebase crashlytics
    var defaultFlutterErrorHandler = FlutterError.onError;
    FlutterError.onError = (details) {
      firebaseHelper.recordFlutterError(details);
      defaultFlutterErrorHandler?.call(details);
    };

    // Record async errors in firebase crashlytics
    var defaultPlatformErrorHandler = PlatformDispatcher.instance.onError;
    PlatformDispatcher.instance.onError = (error, stack) {
      firebaseHelper.recordError(error, stack);
      return defaultPlatformErrorHandler?.call(error, stack) ?? false;
    };*/

    // Set system ui appearance & behaviours for app
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarContrastEnforced: false,
        systemStatusBarContrastEnforced: false,
      ),
    );

    var pref = singletons.pref;

    return runApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthRepository>(create: (_) => singletons<AuthRepository>()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => LocalizationCubit(currentLocale: pref.locale), lazy: false),
            BlocProvider(create: (_) => ThemeBloc(themeMode: ThemeMode.light), lazy: false),
            BlocProvider(create: (context) => UserCubit(context,  UserState()), lazy: false),
          ],
          child: await builder(),
        ),
      ),
    );
  }, (error, stackTrace) {
    log(error.toString(), stackTrace: stackTrace);
  });
}

