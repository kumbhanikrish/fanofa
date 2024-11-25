import 'package:fanofa/bootstrap.dart';
import 'package:fanofa/src/app/bloc_observer.dart';
import 'package:fanofa/src/app/fanofa.dart';
import 'package:fanofa/src/helpers/connectivity_helper.dart';
import 'package:fanofa/src/helpers/deeplink_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gcaptcha_v3/recaptca_config.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  RecaptchaHandler.instance.setupSiteKey(dataSiteKey: "6Lc-uIEqAAAAAFsvKvmgWLmiflXluzedEfgBMkOO");
  bootstrap(
    () async {
      final DeeplinkHelper deeplinkHelper = DeeplinkHelper();
      final ConnectivityHelper connectivityHelper = ConnectivityHelper();
      final initialRoute =
          await deeplinkHelper.getInitialUri().then((value) => value?.path);
      return FanofaApp(
        connectivityHelper: connectivityHelper,
        initialRoute: initialRoute,
      );
    },
    //firebaseOptions: DefaultFirebaseOptions.currentPlatform,
    blocObserver: AppBlocObserver(navigatorKey: navigatorKey),
  );
}
