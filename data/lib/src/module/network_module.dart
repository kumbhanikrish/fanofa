import 'dart:io';

import 'package:core/core.dart' as core;
import 'package:data/src/pref/app_pref.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:network/network.dart';
import 'package:package_info_plus/package_info_plus.dart';

@module
abstract class NetworkModule {
  @singleton
  @preResolve
  Future<CacheService> getCacheService() async {
    var path = await core.cacheDirectory();
    var service = StorageCacheService(storagePath: path);
    await service.init();
    return service;
  }

  String get _deviceType {
    if (Platform.isAndroid) {
      return "1";
    } else if (Platform.isIOS) {
      return "2";
    } else {
      throw UnsupportedError("Unsupported Platform");
    }
  }

  @preResolve
  @singleton
  Future<Dio> getDioInstance({required AppPref pref, required core.Environment environment}) async {
    void onNewTokenData(TokenData data) {
      pref.userToken = data.accessToken;
    }

    final packageInfo = await PackageInfo.fromPlatform();
    var options = BaseOptions(
      baseUrl: environment.baseApi,
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      headers: {
        HttpHeaders.acceptHeader: Headers.jsonContentType,
        HttpHeaders.contentTypeHeader: Headers.jsonContentType,
        'device-type': _deviceType,
        'version-name': packageInfo.version,
        'version-code': packageInfo.buildNumber,
      },
    );

    return Dio(options)
      ..interceptors.addAll([
        AuthInterceptor(
          getAccessToken: () => pref.userToken,
          onNewTokenData: onNewTokenData,
        ),
        if (environment.isLogEnabled) LoggingInterceptor(),
    /*    EncryptionInterceptor(
          encryptionKey: environment.encryptionKey,
          encryptionIv: environment.encryptionIv,
          decryptionKey: environment.decryptionKey,
          decryptionIv: environment.decryptionIv,
          logEnabled: environment.isLogEnabled,
        ),*/
        /* RefreshTokenInterceptor(
          refreshTokenUrl: "${environment.baseApi}user/refresh/token",
          getRefreshToken: () => pref.refreshToken,
          onNewTokenData: onNewTokenData,
          logEnabled: environment.isLogEnabled,
        ),*/
      ]);
  }
}
