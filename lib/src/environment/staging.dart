import 'package:core/core.dart';

class StagingEnvironment extends Environment {
  const StagingEnvironment();

  @override
  final String baseUrl = "http://18.233.162.222:7788";
  @override
  final String baseApi = "http://18.233.162.222:7788";
  @override
  final bool isLogEnabled = false;
}
