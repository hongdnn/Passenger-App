import 'package:flutter/material.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';

typedef CustomItemBuilder<T> = Widget Function(
  BuildContext context,
  T item,
  int index,
);

class CustomCardWidget<T> extends StatelessWidget {
  const CustomCardWidget({
    Key? key,
    this.title,
    this.subTitle,
    this.physics,
    this.itemCount,
    required this.data,
    required this.itemBuilder,
    this.scrollDirection = Axis.vertical,
    this.margin,
  }) : super(key: key);

  final String? title;
  final ScrollPhysics? physics;
  final Axis scrollDirection;
  final Widget? subTitle;
  final List<T> data;
  final CustomItemBuilder<T> itemBuilder;
  final int? itemCount;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    Widget content = const SizedBox();

    if (scrollDirection == Axis.vertical) {
      content = data.isNotEmpty
          ? ListView.builder(
              padding: EdgeInsets.zero,
              physics: physics,
              shrinkWrap: true,
              primary: false,
              itemCount: itemCount ?? data.length,
              itemBuilder: (BuildContext context, int index) {
                return itemBuilder(context, data[index], index);
              },
            )
          : Container();
    } else {
      content = SingleChildScrollView(
        physics: physics,
        scrollDirection: scrollDirection,
        child: Row(
          children:
              List<Widget>.generate(itemCount ?? data.length, (int index) {
            return itemBuilder(context, data[index], index);
          }),
        ),
      );
    }
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          title != null
              ? Container(
                  margin: margin ??
                      EdgeInsets.symmetric(
                        horizontal: 24.w,
                      ),
                  width: double.maxFinite,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title!,
                    style: StylesConstant.ts20w500,
                  ),
                )
              : const SizedBox(),
          SizedBox(
            height: 17.h,
          ),
          subTitle ?? const SizedBox.shrink(),
          subTitle != null
              ? SizedBox(
                  height: 18.h,
                )
              : const SizedBox.shrink(),
          content
        ],
      ),
    );
  }
}
