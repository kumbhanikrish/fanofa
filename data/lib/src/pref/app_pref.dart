import 'dart:convert';

import 'package:data/data.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  final SharedPreferences _preference;

  AppPref(this._preference);

  Future<bool> clear() {
    var showIntro = this.showIntro;
    var locale = this.locale;
    return _preference.clear().whenComplete(() {
      this.showIntro = showIntro;
      this.locale = locale;
    });
  }

  bool get isLogin => userToken.isNotEmpty;

  String get userToken => _preference.getString("user_token") ?? "";

  set userToken(String value) => _preference.setString("user_token", value);

  Locale? get locale => _preference.getString("locale") != null ? Locale(_preference.getString("locale") ?? "en") : null;

  set locale(Locale? value) => value == null ? _preference.remove("locale") : _preference.setString("locale", value.languageCode);

  bool get showIntro => _preference.getBool("show_intro") ?? true;

  set showIntro(bool value) => _preference.setBool("show_intro", value);

  String get fcmToken => _preference.getString("firebaseToken") ?? "";

  set fcmToken(String value) => _preference.setString("firebaseToken", value);

  _setData(String key, Map<String, dynamic>? json) {
    if (json == null || json.isEmpty) {
      _preference.remove(key);
    }
    _preference.setString(key, jsonEncode(json));
  }

  T? _getData<T extends Object>(String key, T Function(Map<String, dynamic> json) parser) {
    if (_preference.containsKey(key)) {
      var value = _preference.get(key);
      if (value is String && value.isNotEmpty) {
        return parser(jsonDecode(value));
      }
    }
    return null;
  }
}
