// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:core/core.dart' as _i494;
import 'package:data/src/module/network_module.dart' as _i448;
import 'package:data/src/module/preference_module.dart' as _i139;
import 'package:data/src/pref/app_pref.dart' as _i7;
import 'package:data/src/services/auth/auth_repository.dart' as _i854;
import 'package:data/src/services/user/user_repository.dart' as _i568;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:network/network.dart' as _i372;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $configureData(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final preferenceModule = _$PreferenceModule();
  final networkModule = _$NetworkModule();
  await gh.singletonAsync<_i7.AppPref>(
    () => preferenceModule.getPreference(),
    preResolve: true,
  );
  await gh.singletonAsync<_i372.CacheService>(
    () => networkModule.getCacheService(),
    preResolve: true,
  );
  await gh.singletonAsync<_i361.Dio>(
    () => networkModule.getDioInstance(
      pref: gh<_i7.AppPref>(),
      environment: gh<_i494.Environment>(),
    ),
    preResolve: true,
  );
  gh.lazySingleton<_i854.AuthRepository>(
      () => _i854.AuthRepository(dio: gh<_i361.Dio>()));
  gh.lazySingleton<_i568.UserRepository>(
      () => _i568.UserRepository(dio: gh<_i361.Dio>()));
  return getIt;
}

class _$PreferenceModule extends _i139.PreferenceModule {}

class _$NetworkModule extends _i448.NetworkModule {}
