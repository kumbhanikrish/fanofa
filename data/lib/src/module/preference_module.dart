import 'package:data/src/pref/app_pref.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class PreferenceModule {
  @singleton
  @preResolve
  Future<AppPref> getPreference() => SharedPreferences.getInstance().then(AppPref.new);
}
