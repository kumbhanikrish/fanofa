import 'package:dio/dio.dart';
import 'package:network/src/token_data.dart';

TokenData? parseTokenData(Response response) {
  String refreshToken = "";
  String accessToken = "";

  /*final cookieHeaders = response.headers["set-cookie"] ?? [];
  for (var cookieHeader in cookieHeaders) {
    final cookies = cookieHeader.split(";");
    for (var cookie in cookies) {
      if(cookie.contains("=")) {
        var [key, value] = cookie.split("=");
        switch (key.trim()) {
          case "accessToken":
            accessToken = value;
            break;
          case "refreshToken":
            refreshToken = value;
            break;
        }
      }
    }
  }*/

  final res = response.data;

  if (res is Map<String, dynamic> && res.keys.contains("access_token") /*&& res.keys.contains("refresh_token")*/) {
    accessToken = res['access_token'];
    //refreshToken = res['refresh_token'];
  }
  if (refreshToken.isNotEmpty && accessToken.isNotEmpty) {
    return TokenData(accessToken: accessToken, /*refreshToken: refreshToken*/);
  }
  return null;
}
