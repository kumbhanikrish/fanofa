import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher_string.dart';

// export 'package:url_launcher/url_launcher.dart' show LaunchMode;
import 'package:url_launcher/url_launcher.dart' as url_launcher;

/*Future<bool> launchUrl(String url, [LaunchMode launchMode = LaunchMode.platformDefault]) async {
  var canLaunch = await canLaunchUrlString(url);
  if (canLaunch) {
    launchUrlString(url, mode: launchMode).whenComplete(() => debugPrint("launchUrl -> $url"));
  }
  return canLaunch;
}*/

Future<bool> launchUrl(String url) async {
  var uri = Uri.parse(url);
  var canLaunch = await url_launcher.canLaunchUrl(uri, );
  if (canLaunch) {
    url_launcher
        .launchUrl(uri, mode: LaunchMode.externalApplication)
        .whenComplete(() => debugPrint("launchUrl -> $url"));
  }
  return canLaunch;
}
