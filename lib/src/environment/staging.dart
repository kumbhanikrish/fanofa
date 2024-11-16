import 'package:core/core.dart';

class StagingEnvironment extends Environment {
  const StagingEnvironment();

  @override
  final String baseUrl = "http://ghanshyam.tapireadyplast.in/api";
  @override
  final String baseApi = "http://ghanshyam.tapireadyplast.in/api";
  @override
  final bool isLogEnabled = false;
}
