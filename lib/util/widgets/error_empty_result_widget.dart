import 'package:flutter/material.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';

class ErrorOrEmptyResultWidget extends StatelessWidget {
  const ErrorOrEmptyResultWidget({
    Key? key,
    required this.errorMessage,
    this.showImage = true,
    this.actions,
  }) : super(key: key);
  final bool showImage;
  final String errorMessage;
  final Widget? actions;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        showImage
            ? Image.asset(
                PngAssets.errorResult,
                height: 200.w,
                width: 200.w,
                fit: BoxFit.cover,
              )
            : const SizedBox(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            errorMessage,
            style: StylesConstant.ts16w400,
          ),
        ),
        actions ?? const SizedBox(),
      ],
    );
  }
}
