import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/core/app_config/navigation/connectivity_service.dart';

class LoggingInterceptor extends Interceptor {
  final StreamController<RequestOptions> _requestStream =
      StreamController<RequestOptions>.broadcast();
  Stream<RequestOptions> get onRequestStream => _requestStream.stream;

  final StreamController<Response<dynamic>> _responseStream =
      StreamController<Response<dynamic>>.broadcast();
  Stream<Response<dynamic>> get onResponseStream => _responseStream.stream;

  final StreamController<DioError> _errorStream =
      StreamController<DioError>.broadcast();
  Stream<DioError> get onErrorStream => _errorStream.stream;

  DioError? _currentDioError;
  DioError? get getCurrentDioError => _currentDioError;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    _logCurl(options);
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        if (_currentDioError == null) {
          _currentDioError = DioError(
            requestOptions: options,
            error: const SocketException('SocketException'),
          );
          getIt<ConnectivityService>().showNoInternetDialog();
        }
      } else {
        _currentDioError = null;
      }
    } catch (_) {
      log('Cannot check activity');
    }

    _requestStream.add(options);

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    log('''RESPONSE[${response.statusCode}] => PATH: ${response.realUri.path}\n=>> Data: ${response.data}''');
    _responseStream.add(response);
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log('''ERROR[${err.response?.statusCode}] => PATH: ${err.response?.realUri.path}\n=>> ${err.response?.data}''');
    _errorStream.add(err);
    return super.onError(err, handler);
  }

  void _logCurl(RequestOptions options) {
    String curl = 'curl --location --request';
    curl += ' ${options.method} ';
    curl += '\'${options.uri.toString()}\'';
    curl += ' \\';
    curl += '--header \'Content-Type: application/json\' \\';
    curl += '--data-raw \'';
    curl += json.encode(options.data);
    curl += '\'';
    log(curl);
  }
}
