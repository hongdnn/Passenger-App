import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';

class PermissionModel {
  PermissionModel({
    required this.title,
    required this.permission,
    this.function,
    this.functionDenied,
  });

  final String title;
  final Permission permission;
  final Function()? function;
  final Function()? functionDenied;
}

class PermissionConfig {
  void askPermissionRequire({
    required List<PermissionModel> listenPermission,
  }) async {
    for (PermissionModel item in listenPermission) {
      PermissionStatus valuePermission = await item.permission.status;
      final PermissionStatus value = await item.permission.request();
      if (valuePermission.isGranted) {
        return;
      } else {
        if (value.isDenied || value.isPermanentlyDenied) {
          item.function?.call();
        } else {
          log('permissioned');
        }
      }
    }
  }
}
