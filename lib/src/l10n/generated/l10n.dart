// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `GhanshyamCake`
  String get appName {
    return Intl.message(
      'GhanshyamCake',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueTitle {
    return Intl.message(
      'Continue',
      name: 'continueTitle',
      desc: '',
      args: [],
    );
  }

  /// `Not now`
  String get notNow {
    return Intl.message(
      'Not now',
      name: 'notNow',
      desc: '',
      args: [],
    );
  }

  /// `You have permanently denied for {permissionName} permission. To enable {permissionName} permission, you need to go to settings and allow us to access {permissionName}.`
  String descPermissionDenied(Object permissionName) {
    return Intl.message(
      'You have permanently denied for $permissionName permission. To enable $permissionName permission, you need to go to settings and allow us to access $permissionName.',
      name: 'descPermissionDenied',
      desc: '',
      args: [permissionName],
    );
  }

  /// `Permission Denied!`
  String get titlePermissionDenied {
    return Intl.message(
      'Permission Denied!',
      name: 'titlePermissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `Go To Settings`
  String get btnGoToSettings {
    return Intl.message(
      'Go To Settings',
      name: 'btnGoToSettings',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get btnCancel {
    return Intl.message(
      'Cancel',
      name: 'btnCancel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter password!`
  String get errorPassword {
    return Intl.message(
      'Please enter password!',
      name: 'errorPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password length should be 8 character & must contain capital letter, small letter, number & an special character [!,@,#,\$,%,^,&,*,_].`
  String get errorPasswordValid {
    return Intl.message(
      'Password length should be 8 character & must contain capital letter, small letter, number & an special character [!,@,#,\\\$,%,^,&,*,_].',
      name: 'errorPasswordValid',
      desc: '',
      args: [],
    );
  }

  /// `Please enter confirm password!`
  String get errorConfirmPassword {
    return Intl.message(
      'Please enter confirm password!',
      name: 'errorConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password didn't match with password!`
  String get errorConfirmPasswordDidNotMatch {
    return Intl.message(
      'Confirm password didn\'t match with password!',
      name: 'errorConfirmPasswordDidNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Please enter email address!`
  String get errorEmail {
    return Intl.message(
      'Please enter email address!',
      name: 'errorEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid email address!`
  String get validErrorEmail {
    return Intl.message(
      'Please enter valid email address!',
      name: 'validErrorEmail',
      desc: '',
      args: [],
    );
  }

  /// `{fieldName} is required.`
  String emptyValidation(Object fieldName) {
    return Intl.message(
      '$fieldName is required.',
      name: 'emptyValidation',
      desc: '',
      args: [fieldName],
    );
  }

  /// `Oops`
  String get labelOops {
    return Intl.message(
      'Oops',
      name: 'labelOops',
      desc: '',
      args: [],
    );
  }

  /// `Something Went Wrong`
  String get errorSomethingWentWrong {
    return Intl.message(
      'Something Went Wrong',
      name: 'errorSomethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `User unauthorized!`
  String get titleUserUnauthorized {
    return Intl.message(
      'User unauthorized!',
      name: 'titleUserUnauthorized',
      desc: '',
      args: [],
    );
  }

  /// `Your session has been expired! Please login again to continue using app.`
  String get descUserUnauthorized {
    return Intl.message(
      'Your session has been expired! Please login again to continue using app.',
      name: 'descUserUnauthorized',
      desc: '',
      args: [],
    );
  }

  /// `Unable to connect to network! Please check your network connection and try again.`
  String get errorNoInternet {
    return Intl.message(
      'Unable to connect to network! Please check your network connection and try again.',
      name: 'errorNoInternet',
      desc: '',
      args: [],
    );
  }

  /// `errorTimeout`
  String get errorTimeout {
    return Intl.message(
      'errorTimeout',
      name: 'errorTimeout',
      desc: '',
      args: [],
    );
  }

  /// `REGISTRATION`
  String get registration {
    return Intl.message(
      'REGISTRATION',
      name: 'registration',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure want to logout?`
  String get areYouSureWantToLogout {
    return Intl.message(
      'Are you sure want to logout?',
      name: 'areYouSureWantToLogout',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Amount`
  String get pleaseEnterAmount {
    return Intl.message(
      'Please Enter Amount',
      name: 'pleaseEnterAmount',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
