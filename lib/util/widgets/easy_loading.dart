import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EasyLoading {
  EasyLoading._internal();

  factory EasyLoading() {
    return _singleton;
  }
  static final EasyLoading _singleton = EasyLoading._internal();
  BuildContext? context;

  showEasyLoading(BuildContext ctx) {
    context = ctx;
    showDialog(
      context: context!,
      builder: (_) => const CupertinoActivityIndicator(
        color: Colors.white,
      ),
    );
  }

  turnOffLoading() {
    Navigator.of(context!).pop();
  }
}
