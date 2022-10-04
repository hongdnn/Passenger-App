import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/util/card_util.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';

enum ValidateType { none, cardNumber, cvv, date, name }

class MessageError {
  MessageError({this.requireMessage = '', this.invalidMessage = ''});

  final String requireMessage;
  final String invalidMessage;
}

class InputCard extends StatefulWidget {
  const InputCard({
    Key? key,
    this.validatorFunc,
    this.hintText = '',
    this.labelText = '',
    this.keyboardType = TextInputType.text,
    this.inputFormatters = const <TextInputFormatter>[],
    this.maxLength = 50,
    this.validateType = ValidateType.none,
  }) : super(key: key);
  final String? Function(String? value)? validatorFunc;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final int? maxLength;
  final ValidateType validateType;

  @override
  State<InputCard> createState() => InputCardState();
}

class InputCardState extends State<InputCard> {
  String? messageError;
  String? value;

  FocusNode focusNode = FocusNode();

  String getMessageErrorRequire() {
    switch (widget.validateType) {
      case ValidateType.name:
        return S(context).please_enter_card_name;
      case ValidateType.none:
        return '';
      case ValidateType.cardNumber:
        return S(context).please_enter_card_number;
      case ValidateType.cvv:
        return S(context).please_enter_cvv;
      case ValidateType.date:
        return S(context).please_enter_card_expired;
      default:
        return '';
    }
  }

  String getMessageInvalid() {
    switch (widget.validateType) {
      case ValidateType.name:
        return S(context).incorrect_information;
      case ValidateType.none:
        return '';
      case ValidateType.cardNumber:
        return S(context).card_number_invalid;
      case ValidateType.cvv:
        return S(context).cvv_number_invalid;
      case ValidateType.date:
        return S(context).expired_date_invalid;
      default:
        return '';
    }
  }

  void validateCardNumber(String input) {
    if (input.isEmpty) {
      setState(() {
        messageError = '*${getMessageErrorRequire()}';
      });
      return;
    }
    if (!CardUtil.validateCardNumWithLuhnAlgorithm(value ?? '')) {
      setState(() {
        messageError = '*${getMessageInvalid()}';
      });
    } else {
      setState(() {
        messageError = null;
      });
    }
  }

  void validateNameCard() {
    if (!CardUtil.validateRequire(value ?? '')) {
      setState(() {
        messageError = '*${getMessageErrorRequire()}';
      });
    } else if (!CardUtil.validateNameCard(value ?? '')) {
      setState(() {
        messageError = '*${getMessageInvalid()}';
      });
    } else {
      setState(() {
        messageError = null;
      });
    }
  }

  void validateCVV() {
    if (value == null || value!.isEmpty) {
      setState(() {
        messageError = '*${getMessageErrorRequire()}';
      });
      return;
    }
    if (!CardUtil.validateCVV(value ?? '')) {
      setState(() {
        messageError = '*${getMessageInvalid()}';
      });
    } else {
      setState(() {
        messageError = null;
      });
    }
  }

  void validateExpireDate() {
    if (value == null || value!.isEmpty) {
      setState(() {
        messageError = '*${getMessageErrorRequire()}';
      });
      return;
    }

    if (!CardUtil.validateDate(value ?? '')) {
      setState(() {
        messageError = '*${getMessageInvalid()}';
      });
    } else {
      setState(() {
        messageError = null;
      });
    }
  }

  bool isShowError() {
    if (widget.validateType == ValidateType.none) {
      return false;
    }
    if (messageError != null && messageError!.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isShowLabel() {
    return widget.labelText != null &&
        widget.labelText!.isNotEmpty &&
        value != null;
  }

  void validateField() {
    switch (widget.validateType) {
      case ValidateType.name:
        validateNameCard();
        break;
      case ValidateType.none:
        break;
      case ValidateType.cardNumber:
        validateCardNumber(value ?? '');
        break;
      case ValidateType.cvv:
        validateCVV();
        break;
      case ValidateType.date:
        validateExpireDate();
        break;
    }
  }

  String getValue() {
    return value ?? '';
  }

  Widget _buildLabel() {
    return Text(
      widget.labelText ?? '',
      style: StylesConstant.ts14w400.copyWith(
        color: ColorsConstant.cFFA33AA3,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 8.h),
          decoration: BoxDecoration(
            border: Border.all(
              color: isShowError()
                  ? ColorsConstant.cFFEB6666
                  : ColorsConstant.cFFE3E4E8,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (isShowLabel())
                Padding(
                  padding: EdgeInsets.only(
                    top: 8.h,
                    left: 12.w,
                  ),
                  child: _buildLabel(),
                ),
              TextFormField(
                onChanged: (String text) {
                  setState(() {
                    value = text;
                  });
                },
                style: StylesConstant.ts16w400
                    .copyWith(color: ColorsConstant.cFF454754),
                focusNode: focusNode
                  ..addListener(() {
                    if (!focusNode.hasFocus &&
                        widget.validateType != ValidateType.none) {
                      validateField();
                    }
                  }),
                maxLength: widget.maxLength,
                inputFormatters: widget.inputFormatters,
                keyboardType: widget.keyboardType,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: isShowLabel() ? 2.h : 16.h,
                    horizontal: 12.w,
                  ),
                  hintText: widget.hintText ?? '',
                  hintStyle: StylesConstant.ts16w400.copyWith(
                    color: ColorsConstant.cFFABADBA,
                  ),
                  fillColor: ColorsConstant.cFF454754,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  counterText: '',
                  helperText: '',
                  errorText: '',
                  errorStyle: const TextStyle(
                    height: -10,
                    fontSize: 0,
                    color: Colors.transparent,
                  ),
                ),
                validator: (String? value) {
                  if (widget.validatorFunc != null) {
                    return widget.validatorFunc?.call(value);
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        if (isShowError())
          Text(
            messageError ?? '',
            style: StylesConstant.ts14w400
                .copyWith(color: ColorsConstant.cFFEB6666),
          ),
        SizedBox(height: 16.h)
      ],
    );
  }
}
