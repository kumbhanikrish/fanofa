import 'package:core/core.dart';

class DevelopmentEnvironment extends Environment {
  const DevelopmentEnvironment();

  @override
   final String baseUrl = "http://ghanshyam.tapireadyplast.in/api";
  // final String baseUrl = "http://192.168.1.165:8000/api/";
  @override
   final String baseApi = "http://ghanshyam.tapireadyplast.in/api";
  // final String baseApi = "https://4f7f-136-232-118-126.ngrok-free.app/api/";
  @override
  final bool isLogEnabled = true;
}
