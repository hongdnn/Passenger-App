import 'package:flutter/material.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/styles.dart';

class CustomInputWidget extends StatelessWidget {
  const CustomInputWidget({
    Key? key,
    this.controller,
    this.hintText,
    this.onChange,
    this.minLines,
    this.maxLines,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
  }) : super(key: key);
  final TextEditingController? controller;
  final String? hintText;
  final Function(String)? onChange;
  final int? minLines;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Function(String value)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: key,
      controller: controller,
      onChanged: onChange,
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      maxLength: maxCharacterInput,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:
            StylesConstant.ts16w400.copyWith(color: ColorsConstant.cFFABADBA),
        filled: true,
        fillColor: ColorsConstant.cFFF7F7F8,
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    );
  }
}
