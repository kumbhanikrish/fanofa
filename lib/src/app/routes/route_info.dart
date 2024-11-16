import 'package:flutter/material.dart';

abstract class RouteInfo {
  final WidgetBuilder builder;
  final bool fullScreenDialog;
  final bool authRequired;

  const RouteInfo({required this.builder, this.fullScreenDialog = false, this.authRequired = true});

  Route call(RouteSettings settings);
}

class MaterialRouteInfo extends RouteInfo {
  const MaterialRouteInfo({required super.builder, super.authRequired, super.fullScreenDialog});

  @override
  Route call(RouteSettings settings) {
    return MaterialPageRoute<Object?>(
      builder: builder,
      settings: settings,
      fullscreenDialog: fullScreenDialog,
    );
  }
}

class FadeRouteInfo extends RouteInfo {
  const FadeRouteInfo({required super.builder, super.authRequired, super.fullScreenDialog});

  @override
  Route call(RouteSettings settings) {
    return PageRouteBuilder<Object?>(
      pageBuilder: (context, animation, _) => builder(context),
      settings: settings,
      fullscreenDialog: fullScreenDialog,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
