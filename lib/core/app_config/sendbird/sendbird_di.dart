import 'package:get_it/get_it.dart';
import 'package:passenger/core/app_config/sendbird/sendbird_config.dart';
import 'package:passenger/util/enum.dart';
import 'package:sendbird_sdk/constant/enums.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';


class SendbirdDI {
  SendbirdDI._();

  static void init(
    GetIt injector, {
    required Environment environment,
  }) {
    switch (environment) {


      case Environment.staging:
        injector.registerLazySingleton(
              () => SendbirdSdk(
            appId: SendBirdApiStagingKey.sendbirdAppID,
            apiToken: SendBirdApiStagingKey.sendbirdApiToken,
          )..setLogLevel(LogLevel.error),
        );

        break;
      case Environment.production:
        injector.registerLazySingleton(
              () => SendbirdSdk(
            appId: SendBirdApiProdKey.sendbirdAppID,
            apiToken: SendBirdApiProdKey.sendbirdApiToken,
          )..setLogLevel(LogLevel.error),
        );
        break;
    }
  }
}
