import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';

class ScreenCollapseAppbar extends StatefulWidget {
  const ScreenCollapseAppbar({
    Key? key,
    this.isLeadingIconBackgroundColor = true,
    this.content = const SizedBox(),
    this.height,
    this.isSliverAppBarScrolled = true,
    this.isShowTitleFlexible = false,
    this.canScroll = true,
    this.flexibleTitle = '',
    this.title = const SizedBox(),
    this.flexibleBackground = const SizedBox(),
    this.isTapOnIconBack,
    this.leadingIcon,
    this.onTapIconBack,
    this.hasTrailingIcon,
  }) : super(key: key);

  final bool isLeadingIconBackgroundColor;
  final Widget content;
  final Widget flexibleBackground;
  final double? height;
  final bool isSliverAppBarScrolled;
  final bool isShowTitleFlexible;
  final Widget title;
  final String flexibleTitle;
  final bool? isTapOnIconBack;
  final bool canScroll;
  final Widget? leadingIcon;
  final VoidCallback? onTapIconBack;
  final bool? hasTrailingIcon;

  @override
  State<ScreenCollapseAppbar> createState() => _ScreenCollapseAppbarState();
}

class _ScreenCollapseAppbarState extends State<ScreenCollapseAppbar> {
  ValueNotifier<bool> hasBottomContent = ValueNotifier<bool>(true);

  void changeBottomContentVisibility(bool value) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      hasBottomContent.value = value;
    });
  }

  void onTapBack() {
    if (widget.isTapOnIconBack != null && widget.isTapOnIconBack == true) {
      Navigator.pop(context);
    }

    widget.onTapIconBack?.call();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: widget.canScroll ? null : const NeverScrollableScrollPhysics(),
      slivers: <Widget>[
        ValueListenableBuilder<bool>(
          valueListenable: hasBottomContent,
          builder: (_, bool newValue, Widget? error) {
            return SliverAppBar(
              centerTitle: true,
              title: widget.isShowTitleFlexible
                  ? widget.title
                  : !widget.isSliverAppBarScrolled
                      ? widget.title
                      : const SizedBox(),
              stretch: true,
              bottom: hasBottomContent.value
                  ? PreferredSize(
                      preferredSize: Size(10.w, 10.w),
                      child: Container(
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24.w),
                            topRight: Radius.circular(24.w),
                          ),
                        ),
                      ),
                    )
                  : const PreferredSize(
                      preferredSize: Size(0, 0),
                      child: SizedBox(),
                    ),
              titleSpacing: 0,
              actions: <Widget>[
                widget.hasTrailingIcon  == true ? Transform.translate(
                  offset: Offset(0.h, -15.h),
                  child: GestureDetector(
                    onTap: () {
                      onTapBack();
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 22.w),
                      child: SvgPicture.asset(
                        SvgAssets.icCloseRating,
                        width: 15,
                        height: 15,
                      ),
                    ),
                  ),
                ) : const SizedBox.shrink(),
              ],
              leading: widget.hasTrailingIcon == false
                  ? InkWell(
                      onTap: () {
                        onTapBack();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 16.w),
                        child: CircleAvatar(
                          backgroundColor: widget.isLeadingIconBackgroundColor
                              ? Colors.white
                              : Colors.transparent,
                          child: Center(
                            child: widget.leadingIcon ??
                                SvgPicture.asset(
                                  SvgAssets.icBackIos,
                                  color: Colors.black,
                                ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              expandedHeight:
                  widget.isSliverAppBarScrolled ? widget.height ?? 220.h : 0.h,
              pinned: true,
              floating: false,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext _, BoxConstraints constraints) {
                  changeBottomContentVisibility(
                    constraints.biggest.height > 110.h &&
                        widget.isSliverAppBarScrolled == true,
                  );
                  return FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      constraints.biggest.height <= 110.h &&
                              widget.isSliverAppBarScrolled == true
                          ? widget.flexibleTitle
                          : '',
                      style: StylesConstant.ts20w500,
                      textAlign: TextAlign.center,
                    ),
                    background: widget.flexibleBackground,
                  );
                },
              ),
            );
          },
        ),
        SliverToBoxAdapter(
          child: Container(
            color: Colors.white,
            child: widget.content,
          ),
        )
      ],
    );
  }
}
