import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';

class CustomFloatingButton extends StatefulWidget {
  const CustomFloatingButton({
    Key? key,
    required this.onTap,
    required this.showFillColor,
    required this.controller,
    required this.onTapHistoryIcon,
  }) : super(key: key);
  final void Function() onTap;
  final void Function() onTapHistoryIcon;
  final bool showFillColor;
  final AnimationController controller;

  @override
  State<CustomFloatingButton> createState() => _CustomFloatingButtonState();
}

class _CustomFloatingButtonState extends State<CustomFloatingButton>
    with TickerProviderStateMixin {
  late Animation<double> _animation;

  @override
  void initState() {
    _animation = CurvedAnimation(
      parent: widget.controller,
      curve: Curves.easeIn,
    );
    super.initState();
  }

  void _onTapItemFLoating() {
    widget.onTap();
    widget.onTapHistoryIcon();
    widget.controller.isDismissed
        ? widget.controller.forward()
        : widget.controller.reverse();
  }

  final ValueNotifier<bool> showFloatButton = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: showFloatButton,
      builder: (_, bool value, __) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizeTransition(
              sizeFactor: _animation,
              axis: Axis.vertical,
              axisAlignment: 1,
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _ItemButtonFloating(
                      icon: SvgAssets.icHeartBorder,
                      title: S(context).favorites,
                      onTap: _onTapItemFLoating,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    _ItemButtonFloating(
                      icon: SvgAssets.icMenu,
                      title: S(context).activity,
                      onTap: _onTapItemFLoating,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    _ItemButtonFloating(
                      icon: SvgAssets.icCommentsAltsvg,
                      title: S(context).message,
                      onTap: _onTapItemFLoating,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            _ItemButtonFloating(
              isParrentButton: true,
              icon: SvgAssets.icFloatingMenu,
              title: '',
              onTap: () {
                widget.onTap();
                widget.controller.isDismissed
                    ? widget.controller.forward()
                    : widget.controller.reverse();
              },
            ),
          ],
        );
      },
    );
  }
}

class _ItemButtonFloating extends StatelessWidget {
  const _ItemButtonFloating({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isParrentButton = false,
  }) : super(key: key);
  final String title;
  final String icon;
  final bool isParrentButton;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: StylesConstant.ts16w500.copyWith(
            color: ColorsConstant.cWhite,
          ),
        ),
        SizedBox(width: 10.w),
        InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(47),
          ),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(isParrentButton ? 2 : 0),
            width: !isParrentButton ? 47.w : 50.w,
            height: !isParrentButton ? 47.h : 50.h,
            decoration: BoxDecoration(
              gradient:
                  isParrentButton ? ColorsConstant.appPrimaryGradient : null,
              shape: BoxShape.circle,
              color: !isParrentButton ? ColorsConstant.cWhite : null,
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: ColorsConstant.c80Black,
                  blurRadius: 2,
                  offset: Offset(1, 2), // changes position of shadow
                ),
              ],
            ),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: ColorsConstant.cWhite,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  icon,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
