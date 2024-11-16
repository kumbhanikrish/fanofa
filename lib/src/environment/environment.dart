import 'package:core/core.dart';

import 'development.dart';
import 'production.dart';
import 'staging.dart';

export 'development.dart';
export 'production.dart';
export 'staging.dart';

class EnvironmentSelector {
  const EnvironmentSelector();

  Environment call() {
    const env = String.fromEnvironment("env", defaultValue: "development");
    switch (env) {
      case "staging":
        return const StagingEnvironment();
      case "production":
        return const ProductionEnvironment();
      default:
        return const DevelopmentEnvironment();
    }
  }
}
