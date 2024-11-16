import 'package:fanofa/main.dart';
import 'package:fanofa/src/app/localization/localization_cubit.dart';
import 'package:fanofa/src/app/routes/routes.dart';
import 'package:fanofa/src/di/mixin.dart';
import 'package:fanofa/src/helpers/connectivity_helper.dart';
import 'package:fanofa/src/l10n/l10n.dart';
import 'package:fanofa/src/logic/theme/theme_cubit.dart';
import 'package:fanofa/src/packages/resouces/src/theme/bloc/theme_bloc.dart';
import 'package:fanofa/src/packages/resouces/src/theme/theme.dart';
import 'package:fanofa/src/ui/auth/login_view.dart';
import 'package:fanofa/src/ui/auth/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class FanofaApp extends StatefulWidget {
  final ConnectivityHelper connectivityHelper;
  final String? initialRoute;
  const FanofaApp({super.key,   this.initialRoute,  required this.connectivityHelper,});

  @override
  State<FanofaApp> createState() => _FanofaAppState();
}

class _FanofaAppState extends State<FanofaApp> with SingletonsMixin{
  late final AppRouteGenerator _routeGenerator = AppRouteGenerator(pref: pref);
  late final routeObserver = this<RouteObserver>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void activate() {
    super.activate();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    widget.connectivityHelper.dispose();
    super.dispose();
  }

  String get initialRoute {
    if (pref.isLogin) {
      return RegisterView.routeName;
     // return MainView.routeName;
    }
    return RegisterView.routeName;
  }
  @override
  Widget build(BuildContext context) {
    final localizationState = BlocProvider.of<LocalizationCubit>(context, listen: true).state;
    final themeState = BlocProvider.of<ThemeBloc>(context, listen: true).state;

    return MaterialApp(
      onGenerateTitle: (context) => context.l10n.appName,
      navigatorKey: navigatorKey,
      navigatorObservers: [routeObserver],
      debugShowCheckedModeBanner: false,
      themeMode: themeState.themeMode,
      theme: AppTheme.lightTheme,
      onGenerateRoute: _routeGenerator.call,
      initialRoute: initialRoute,

      color: Colors.white,
      locale: localizationState.locale,
      supportedLocales: localizationState.supportedLocales,
      localizationsDelegates:  const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
