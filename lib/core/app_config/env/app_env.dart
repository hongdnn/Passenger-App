import 'dart:developer';

import 'package:passenger/core/app_config/env/network_config.dart';
import 'package:passenger/util/enum.dart';

const String envKey = 'env';
const Environment defaultEnv = Environment.staging;

class AppEnvironment {
  Environment currentEnv = defaultEnv;

  EnvConfig? _config;

  EnvConfig getConfig() {
    if (_config != null) return _config!;

    final String env = String.fromEnvironment(
      envKey,
      defaultValue: defaultEnv.name,
    );

    log('[AppEnvironment] Launching in $env');
    currentEnv = Environment.values.byName(env);

    EnvConfig? currentConfig;
    if (env == Environment.staging.name) {
      currentConfig = StagingConfig();
    } else if (env == Environment.production.name) {
      currentConfig = ProductionConfig();
    }

    _config = currentConfig;
    if (_config != null) {
      return _config!;
    } else {
      return throw Exception('No such environment=$env');
    }
  }
}

abstract class EnvConfig {
  NetworkConfig get networkConfig;
}

class StagingConfig extends EnvConfig {
  @override
  NetworkConfig get networkConfig => StagingNetworkConfig(
        rhBaseUrl: 'https://rbh-rh-cs-dev-api.gcp.alp-robinhood.com/v1/rhc',
        ggBaseUrl: 'https://maps.googleapis.com/maps/api',
      );
}

class ProductionConfig extends EnvConfig {
  @override
  NetworkConfig get networkConfig => ProductionNetworkConfig(
        rhBaseUrl: 'https://rbh-rh-cs-dev-api.gcp.alp-robinhood.com/v1/rhc',
        ggBaseUrl: 'https://maps.googleapis.com/maps/api',
      );
}
