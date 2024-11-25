import 'package:core/core.dart';

class DevelopmentEnvironment extends Environment {
  const DevelopmentEnvironment();

  @override
   final String baseUrl = "http://18.233.162.222:7788";
  // final String baseUrl = "http://192.168.1.165:8000/api/";
  @override
   final String baseApi = "http://18.233.162.222:7788";
  // final String baseApi = "https://4f7f-136-232-118-126.ngrok-free.app/api/";
  @override
  final bool isLogEnabled = true;
}
