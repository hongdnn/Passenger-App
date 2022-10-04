import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passenger/util/size.dart';

Future<T?> showCustomModalBottomSheet<T>({
  required BuildContext context,
  required Widget content,
  Color? barrierColor,
  bool? barrierDismissible,
  double? borderRadius,
  bool enableDrag = false,
  Color backgroundColor = Colors.transparent,
}) {
  return showModalBottomSheet(
    context: context,
    enableDrag: enableDrag,
    barrierColor: barrierColor ?? kCupertinoModalBarrierColor,
    isDismissible: barrierDismissible ?? true,
    isScrollControlled: true,
    backgroundColor: backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(borderRadius ?? 20.0.w),
        topRight: Radius.circular(borderRadius ?? 20.0.w),
      ),
    ),
    builder: (BuildContext context) {
      return content;
    },
  );
}
