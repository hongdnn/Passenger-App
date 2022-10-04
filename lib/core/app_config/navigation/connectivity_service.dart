import 'package:dio/dio.dart';
import 'package:passenger/core/app_config/dio/logging_interceptor.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/main.dart';
import 'package:passenger/util/widgets/custom_dialog.dart';

class ConnectivityService {
  ConnectivityService() {
    setupStreamListen();
  }

  void showNoInternetDialog() {
    showCustomDialog(
      context: navigatorKey.currentContext!,
      options: CustomDialogParams.simpleAlert(
        title: S(navigatorKey.currentContext!).no_internet_title,
        message: S(navigatorKey.currentContext!).no_internet_msg,
        negativeTitle: S(navigatorKey.currentContext!).no_internet_button_title,
      ),
    );
  }

  setupStreamListen() {
    getIt<LoggingInterceptor>().onErrorStream.listen((DioError event) async {
      await openDialog(
        title:
            '''${event.requestOptions.baseUrl}${event.requestOptions.path}\ncode: ${event.response?.statusCode}''',
        content: event.error.toString(),
      );
    });
  }

  Future<void> openDialog({String? title, String? content}) async {
    showCustomDialog(
      context: navigatorKey.currentContext!,
      options: CustomDialogParams.simpleAlert(
        title: title,
        message: content,
        negativeTitle: S(navigatorKey.currentContext!).no_internet_button_title,
      ),
    );
  }
}
