import 'package:flutter/material.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';

class TitleAndHeaderWidget extends StatelessWidget {
  const TitleAndHeaderWidget({
    Key? key,
    this.onTapSubtitle,
    this.subtitle,
    required this.title,
  }) : super(key: key);
  final String title;
  final String? subtitle;
  final Function()? onTapSubtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8.w, top: 24.w, left: 24.w, right: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: StylesConstant.ts16w500,
          ),
          subtitle != null
              ? InkWell(
                  onTap: () {
                    onTapSubtitle?.call();
                  },
                  child: Text(
                    subtitle!,
                    style: StylesConstant.ts14w500.copyWith(
                      color: ColorsConstant.cFFA33AA3,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
