import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/util/styles.dart';
import 'package:passenger/util/widgets/custom_button.dart';
import 'package:permission_handler/permission_handler.dart';

Future<dynamic> showCommonErrorDialog({
  required BuildContext context,
  bool dismissible = true,
  Color backgroundColor = Colors.white,
  Function()? onPressed,
  required String message,
  required String negativeTitle,
  String title = '',
}) {
  return showCustomDialog(
    context: context,
    title: title,
    options: CustomDialogParams.simpleAlert(
      message: message,
      negativeTitle: negativeTitle,
      onPressed: onPressed,
    ),
    dismissible: dismissible,
    backgroundColor: backgroundColor,
  );
}

Future<dynamic> showCustomDialog({
  required BuildContext context,
  required CustomDialogParams options,
  bool dismissible = true,
  Color backgroundColor = Colors.white,
  String title = '',
}) {
  return showDialog(
    context: context,
    barrierDismissible: dismissible,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content:
            CustomDialog(params: options, backgroundColor: backgroundColor),
      );
    },
  );
}

Future<dynamic> showCustomDialogLoading({
  required BuildContext context,
  bool dismissible = true,
}) {
  return showDialog(
    context: context,
    barrierDismissible: dismissible,
    builder: (BuildContext context) {
      return const Center(child: CupertinoActivityIndicator());
    },
  );
}

Future<dynamic> showCustomDialogPermission({
  required BuildContext context,
  required String permission,
  required Function(BuildContext) functionContext,
}) {
  return showCustomDialog(
    dismissible: false,
    context: context,
    options: CustomDialogParams.simpleAlert(
      title: S(context).required,
      message: '$permission ${S(context).permission_is_required}',
      negativeTitle: S(context).setting,
      dismissOnPressed: false,
      onPressed: () {
        functionContext(context);
        openAppSettings();
      },
    ),
  );
}

class CustomDialogParams {
  CustomDialogParams({
    this.positiveParams,
    this.negativeParams,
    this.title,
    this.message,
  });

  /// A simple dialog will only has 1 negative button,
  /// when button is clicked, the dialog simply dismissed
  ///
  /// @param title: title of the dialog
  ///
  /// @param message: message of the dialog
  ///
  /// @param negativeTitle: title of negative option
  factory CustomDialogParams.simpleAlert({
    String? title,
    String? message,
    String? negativeTitle,
    Function()? onPressed,
    bool? dismissOnPressed,
  }) {
    return CustomDialogParams(
      title: title,
      message: message,
      negativeParams: CustomDialogButtonParams(
        dismissOnPressed: dismissOnPressed ?? true,
        title: negativeTitle ?? '',
        onPressed: onPressed,
        hasGradient: true,
      ),
    );
  }

  final String? title;
  final String? message;
  final CustomDialogButtonParams? positiveParams;
  final CustomDialogButtonParams? negativeParams;
}

class CustomDialogButtonParams {
  CustomDialogButtonParams({
    required this.title,
    this.hasGradient = false,
    this.onPressed,
    this.dismissOnPressed = true,
  });

  final String title;
  final bool hasGradient;
  final VoidCallback? onPressed;
  final bool dismissOnPressed;
}

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    required this.params,
    required this.backgroundColor,
  }) : super(key: key);

  final CustomDialogParams params;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Wrap(
        children: <Widget>[
          Container(
            // Since AlertDialog already has some padding
            padding: const EdgeInsets.symmetric(vertical: 4),
            color: backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _title(),
                _subtitle(),
                const SizedBox(height: 24),
                _buttonsRow(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _title() {
    if (params.title == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        params.title!,
        textAlign: TextAlign.center,
        style: StylesConstant.ts20w500,
      ),
    );
  }

  Widget _subtitle() {
    if (params.message == null) return const SizedBox.shrink();
    return Text(
      params.message!,
      textAlign: TextAlign.center,
      style: StylesConstant.ts14w400,
    );
  }

  Widget _buttonsRow(BuildContext context) {
    final bool hasBothButton =
        params.negativeParams != null && params.positiveParams != null;
    return Row(
      children: <Widget>[
        _button(context, params.negativeParams),
        if (hasBothButton) const SizedBox(width: 16),
        _button(context, params.positiveParams),
      ],
    );
  }

  Widget _button(BuildContext context, CustomDialogButtonParams? options) {
    if (options == null) return const SizedBox.shrink();
    final CustomButtonParams params = options.hasGradient
        ? CustomButtonParams.primary(
            text: options.title,
            onPressed: () => _onButtonPressed(context, options),
          )
        : CustomButtonParams.secondary(
            text: options.title,
            onPressed: () => _onButtonPressed(context, options),
          );
    return Expanded(child: CustomButton(params: params));
  }

  void _onButtonPressed(
    BuildContext context,
    CustomDialogButtonParams options,
  ) {
    if (options.dismissOnPressed) {
      Navigator.of(context).pop();
    }

    options.onPressed?.call();
  }
}
