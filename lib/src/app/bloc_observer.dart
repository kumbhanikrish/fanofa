import 'dart:async';
import 'dart:developer' as developer;

import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:fanofa/src/common/alerts.dart';
import 'package:fanofa/src/di/mixin.dart';
import 'package:fanofa/src/l10n/l10n.dart';
import 'package:fanofa/src/packages/components/src/widgets/modals.dart';
import 'package:fanofa/src/ui/auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppBlocObserver extends BlocObserver with SingletonsMixin {
  final GlobalKey<NavigatorState> _navigatorKey;

  AppBlocObserver({required GlobalKey<NavigatorState> navigatorKey}) : _navigatorKey = navigatorKey;

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    developer.log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    developer.log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    if (error is ApiException) _handleApiException(error);
    super.onError(bloc, error, stackTrace);
  }
  Future<void> _handleApiException(ApiException exception) async {
    var context = _navigatorKey.currentContext;
    if (context == null) return;
    if (exception is TimeoutException) {
      return showErrorMessage(context: context, title: context.l10n.labelOops, content: context.l10n.errorTimeout);
    }
    if (exception is InternetConnectionException) {
      return showErrorMessage(context: context, title: context.l10n.labelOops, content: context.l10n.errorNoInternet);
    }
    if (exception is UnauthorizedException) {
      pref.clear();
      showErrorSheet(
        context: context,
        title: exception.message ?? "",
        // content: exception.message ?? "",
        button: ModalButton(
          label: "Okay",
          onPressed: () => context.navigator.pop(),
        ),
      );
      // showErrorMessage(context: context, title: context.l10n.titleUserUnauthorized, content: context.l10n.descUserUnauthorized);
      context.navigator.pushNamedAndRemoveUntil(LoginView.routeName, (route) => false);
    }
    if (exception is ApiResponseException) {

      /* if (exception.errors != null && exception.errors!.isNotEmpty) {
        //String error = exception.errors?.map((e) => e).fold("", (previousValue, element) => "$previousValue• ${element.values}\n") ?? "";

    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      content: CommonText.medium(
        "${exception.message}",
        size: 14,
        maxLines: 5,
        color: context.colorScheme.primary,
      ),
      backgroundColor: context.colorScheme.background,
    ));

      }*/  if (exception.message != null && exception.message!.isNotEmpty) {
        showErrorSheet(
          context: context,
          title: exception.message ?? "",
          //content: "",
          button: ModalButton(
            label: "Okay",
            onPressed: () => context.navigator.pop(),
          ),
        );
      } else {
        showErrorMessage(context: context, title: context.l10n.labelOops, content: context.l10n.errorSomethingWentWrong);
      }
    }
  }
  bool _userInView(String routeName) {
    String? currentPath;
    _navigatorKey.currentContext!.navigator.popUntil((route) {
      currentPath = route.settings.name;
      return true;
    });
    return currentPath?.contains(routeName) ?? false;
  }
/*void _handleApiException(ApiException exception) {
    print("ApiResponseException:: ${exception.message}");
    var context = _navigatorKey.currentContext;
    if (context == null) return;
    if (exception is TimeoutException) {
      return showErrorMessage(context: context, title: context.l10n.labelOops, content: context.l10n.errorTimeout);
    }
    if (exception is InternetConnectionException) {
      return showErrorMessage(context: context, title: context.l10n.labelOops, content: context.l10n.errorNoInternet);
    }
    if (exception is UnauthorizedException) {
      pref.clear();
      //pref.showIntro = false;
      context.navigator.pushNamedAndRemoveUntil(LoginView.routeName, (route) => false);
      return showErrorMessage(context: context, title: context.l10n.titleUserUnauthorized, content: context.l10n.descUserUnauthorized);
    }
    if (exception is ApiResponseException) {
      print("ApiResponseException:: ${exception}");
      if (exception.errors != null && exception.errors!.isNotEmpty) {
        String error = exception.errors?.map((e) => e).fold("", (previousValue, element) => "$previousValue• ${element.values}\n") ?? "";
        showErrorMessage(
          context: context,
          title: context.l10n.labelOops,
          content: error,
        );
      } else if (exception.message != null && exception.message!.isNotEmpty) {
        showErrorMessage(context: context, title: context.l10n.labelOops, content: exception.message!);
      } else {
        showErrorMessage(context: context, title: context.l10n.labelOops, content: context.l10n.errorSomethingWentWrong);
      }
    }
  }*/
}
