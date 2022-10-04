import 'package:flutter/foundation.dart';

import 'data_alert.dart';

typedef VoidCallBack = void Function();
typedef VoidCallBackListenerTab = void Function(
  Map<String, dynamic>?,
  TypeAlert,
);
typedef VoidCallBackWithValue = void Function(
  String,
  String,
  TypeAlert, [
  Map<String, dynamic>?,
]);

class AlertController {
  factory AlertController() => instance!;

  AlertController._init() {
    if (kDebugMode) {
      print('AlertController was created!');
    }
  }
  // Show callback, can call anywhere
  VoidCallBackWithValue? _show;

  // Hide callback, can call anywhere
  VoidCallBack? _hide;

  // Listener callback when tab on the alert
  VoidCallBackListenerTab? _tabListener;

  static AlertController? instance = AlertController._init();

  static onTabListener(VoidCallBackListenerTab tabListener) {
    instance?._tabListener = tabListener;
  }

  VoidCallBackListenerTab getTabListener() {
    return _tabListener!;
  }

  bool isCallbackNull() {
    if (_tabListener == null) {
      return true;
    }
    return false;
  }

  static show(
    String title,
    String message,
    TypeAlert type, [
    Map<String, dynamic>? payload,
  ]) {
    instance?._show!(title, message, type, payload);
  }

  static hide() {
    instance?._hide!();
  }

  setShow(VoidCallBackWithValue show) {
    _show = show;
  }

  setHide(VoidCallBack hide) {
    _hide = hide;
  }

  // Dispose the alert controller when app dispose
  dispose() {
    _show = null;
    _hide = null;
    _tabListener = null;
  }
}
