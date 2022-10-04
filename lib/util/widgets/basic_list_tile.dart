import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';

class BasicListTile extends StatelessWidget {
  const BasicListTile({
    Key? key,
    this.icon,
    this.title,
    this.subtitle,
    this.onTap,
    this.iconTitle,
  }) : super(key: key);

  final String? icon;
  final String? title;
  final String? subtitle;
  final Function()? onTap;
  final Widget? iconTitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 5.h),
        child: Row(
          children: <Widget>[
            icon != null && icon!.isNotEmpty
                ? Container(
                    height: 40.w,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: ColorsConstant.cFFF7F7F8,
                      borderRadius: BorderRadius.all(Radius.circular(8.w)),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        icon ?? '',
                        width: 20.w,
                        height: 20.w,
                        color: ColorsConstant.cFF73768C,
                      ),
                    ),
                  )
                : const SizedBox(),
            SizedBox(
              width: 12.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      title != null
                          ? Expanded(
                              child: Text(
                                title!,
                                overflow: TextOverflow.ellipsis,
                                style: StylesConstant.ts16w500,
                              ),
                            )
                          : const SizedBox(),
                      iconTitle ?? const SizedBox()
                    ],
                  ),
                  (subtitle != null)
                      ? Container(
                          alignment: Alignment.centerLeft,
                          width: double.maxFinite,
                          child: Text(
                            subtitle!,
                            overflow: TextOverflow.ellipsis,
                            style: StylesConstant.ts14w400.copyWith(
                              color: ColorsConstant.cFF73768C,
                            ),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
