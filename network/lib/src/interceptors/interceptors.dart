import 'package:network/src/token_data.dart';

typedef TokenDataCallback = void Function(TokenData data);
typedef GetTokenCallback = String? Function();
typedef Callback = bool? Function();
typedef GetHeadersCallback = Map<String, dynamic> Function();
