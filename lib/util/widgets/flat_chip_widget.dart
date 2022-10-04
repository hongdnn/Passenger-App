import 'package:flutter/material.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';

class FlatChip extends StatelessWidget {
  const FlatChip({
    Key? key,
    this.onPressed,
    required this.text,
    this.icon,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.h,
      child: Material(
        borderRadius: BorderRadius.circular(20.w),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.w),
          ),
          onTap: onPressed,
          child: Ink(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 6.h,
            ),
            child: Row(
              children: <Widget>[
                icon ?? const SizedBox.shrink(),
                SizedBox(width: 4.w),
                Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: StylesConstant.ts14w400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
