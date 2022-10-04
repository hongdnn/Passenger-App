import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';


void logi({String? tag, BuildContext? context, required String message}) {
  getIt
      .get<LoggerConfig>()
      .logi(message: message, context: context, tag: tag);
}

void loge({String? tag, BuildContext? context, required String message}) {
  getIt
      .get<LoggerConfig>()
      .loge(message: message, context: context, tag: tag);
}

class LoggerConfig {
  LoggerConfig();

  void logi({
    String? tag,
    BuildContext? context,
    required String message,
  }) {
    if (kReleaseMode) return;
    if(context==null){
      log('⚠️${tag ?? ''}: $message');
    }else{
      log('⚠️${tag ?? ''} from ${context.widget}: $message');
    }
  }

  void loge({
    String? tag,
    BuildContext? context,
    required String message,
  }) {
    if (kReleaseMode) return;
    if(context==null){
      log('🆘️${tag ?? ''}: $message');
    }else{
      log('🆘️${tag ?? ''} from: ${context.widget}: $message');
    }
  }
}
