import 'package:core/core.dart';

class ProductionEnvironment extends Environment {
  const ProductionEnvironment();

  @override
  final String baseUrl = "http://ghanshyam.tapireadyplast.in/api";
  @override
  final String baseApi = "http://ghanshyam.tapireadyplast.in/api";
  @override
  final bool isLogEnabled = false;
}
