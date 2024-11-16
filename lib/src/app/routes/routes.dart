import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:fanofa/src/ui/auth/complete_profile.dart';
import 'package:fanofa/src/ui/auth/login_view.dart';
import 'package:fanofa/src/ui/auth/register_view.dart';
import 'package:flutter/material.dart';
import 'route_info.dart';

class AppRouteGenerator {
  final AppPref pref;

  AppRouteGenerator({required this.pref});

  Route? call(RouteSettings settings) {
    Log.debug("${settings.name} -> ${settings.arguments}");
    var routeName = settings.name;

    var routeInfo = _routes[routeName];
    if (routeInfo == null) return null;
    // if(routeName == "/date_time_Select"){
    //   final args = settings.arguments as CustomerDetailsArguments;
    // }
    // return routeInfo.builder(settings.arguments);
    return routeInfo(settings);
  } 

  final Map<String, RouteInfo> _routes = {
    LoginView.routeName: const MaterialRouteInfo(builder: LoginView.builder),
    RegisterView.routeName: const MaterialRouteInfo(builder: RegisterView.builder),
    CompleteProfileView.routeName: const MaterialRouteInfo(builder: CompleteProfileView.builder),
  };

  
}
