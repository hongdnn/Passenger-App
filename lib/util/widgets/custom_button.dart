import 'package:flutter/widgets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';

class CustomButtonParams {
  CustomButtonParams({
    this.height,
    this.width,
    required this.text,
    this.onPressed,
    this.margin,
    this.padding,
    this.boxShadow,
    this.radius = 24,
    this.textStyle,
    this.gradient,
    this.backgroundColor,
    this.wrapWidth = false,
  });

  factory CustomButtonParams.primary({
    required String text,
    VoidCallback? onPressed,
    bool hasGradient = true,
    bool wrapWidth = false,
    Color? backgroundColor,
    EdgeInsets? padding,
    TextStyle? textStyle,
  }) {
    return CustomButtonParams(
      text: text,
      padding: padding,
      textStyle: textStyle ?? StylesConstant.ts16w500cWhite,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      gradient: hasGradient ? ColorsConstant.appPrimaryGradient : null,
      wrapWidth: wrapWidth,
    );
  }

  factory CustomButtonParams.secondary({
    required String text,
    VoidCallback? onPressed,
  }) {
    return CustomButtonParams(
      text: text,
      textStyle: StylesConstant.ts16w500cWhite.copyWith(
        color: ColorsConstant.cFFA33AA3,
      ),
      onPressed: onPressed,
    );
  }

  factory CustomButtonParams.primaryUnselected({
    required String text,
    VoidCallback? onPressed,
  }) {
    return CustomButtonParams(
      text: text,
      onPressed: onPressed,
      textStyle:
          StylesConstant.ts14w400.copyWith(color: ColorsConstant.cFF73768C),
      backgroundColor: ColorsConstant.cFFF7F7F8,
    );
  }

  final double? height;
  final double? width;
  final String text;
  final VoidCallback? onPressed;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final List<BoxShadow>? boxShadow;
  final double radius;
  final TextStyle? textStyle;
  final Gradient? gradient;
  final Color? backgroundColor;
  final bool wrapWidth;

  CustomButtonParams copyWith({
    double? height,
    double? width,
    String? text,
    VoidCallback? onPressed,
    EdgeInsets? margin,
    EdgeInsets? padding,
    List<BoxShadow>? boxShadow,
    double? radius,
    TextStyle? textStyle,
    Gradient? gradient,
    Color? backgroundColor,
    bool? wrapWidth,
  }) =>
      CustomButtonParams(
        height: height ?? this.height,
        width: width ?? this.width,
        text: text ?? this.text,
        onPressed: onPressed ?? this.onPressed,
        margin: margin ?? this.margin,
        padding: padding ?? this.padding,
        boxShadow: boxShadow ?? this.boxShadow,
        radius: radius ?? this.radius,
        textStyle: textStyle ?? this.textStyle,
        gradient: gradient ?? this.gradient,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        wrapWidth: wrapWidth ?? this.wrapWidth,
      );
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.params,
  }) : super(key: key);

  final CustomButtonParams params;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: params.onPressed,
      child: Container(
        margin: params.margin,
        padding: params.padding ??
            EdgeInsets.symmetric(
              vertical: 8.h,
              horizontal: 20.w,
            ),
        height: params.height == null ? null : params.height!.h,
        width: params.width == null ? null : params.width!.w,
        decoration: BoxDecoration(
          boxShadow: params.boxShadow,
          gradient: params.backgroundColor == null ? params.gradient : null,
          borderRadius: BorderRadius.circular(params.radius),
          color: params.backgroundColor,
        ),
        child: params.wrapWidth
            ? _text()
            : Center(
                child: _text(),
              ),
      ),
    );
  }

  Text _text() {
    return Text(
      params.text,
      style: params.textStyle,
    );
  }
}
