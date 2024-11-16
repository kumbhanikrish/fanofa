import 'dart:async';

import 'package:app_links/app_links.dart';


typedef DeepLinkCallBack = void Function(Uri uri);

class DeeplinkHelper {
  DeeplinkHelper();

  late final DeepLinkCallBack deepLinkCallBack;
  late final StreamSubscription _subscription;

  /// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState({required void Function(Uri uri) deepLinkCallBack}) async {
    this.deepLinkCallBack = deepLinkCallBack;
    _subscription = AppLinks().uriLinkStream.listen((uri) {
      if (uri.path.isNotEmpty) deepLinkCallBack(uri);
    });
  }

  Future<Uri?> getInitialUri() => AppLinks().getInitialLink();

  void dispose() => _subscription.cancel();
}
