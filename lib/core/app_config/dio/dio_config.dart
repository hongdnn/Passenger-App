import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:passenger/core/app_config/env/app_env.dart';
import 'package:passenger/core/app_config/dio/logging_interceptor.dart';
import 'package:passenger/core/app_config/env/network_config.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';

class DioConfig {
  DioConfig._();

  static Future<void> initDi() async {
    getIt.registerLazySingleton(() => LoggingInterceptor());
    final AppEnvironment appEnv = getIt<AppEnvironment>();
    final NetworkConfig networkConfig = appEnv.getConfig().networkConfig;
    getIt.registerFactory<Dio>(() {
      final Dio dio = Dio(
        BaseOptions(
          connectTimeout: networkConfig.connectTimeoutMillis,
          receiveTimeout: networkConfig.receiveTimeoutMillis,
          headers: networkConfig.headers,
        ),
      );
      // Interceptors
      if (kDebugMode) {
        dio.interceptors.add(
          getIt<LoggingInterceptor>(),
        );
      }

      return dio;
    });
  }
}
