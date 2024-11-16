library data;

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'data.config.dart';

export 'package:network/network.dart';

export 'src/model/model.dart';
export 'src/model_helpers.dart';
export 'src/pref/app_pref.dart';
export 'src/services/services.dart';

@InjectableInit(initializerName: r'$configureData', ignoreUnregisteredTypes: [Environment], asExtension: false)
Future<GetIt> configureData(GetIt getInstance) => $configureData(getInstance);
