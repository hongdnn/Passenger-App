// ignore_for_file: unnecessary_this

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passenger/util/size.dart';

import 'alert_controller.dart';
import 'data_alert.dart';

typedef VoidCallBack = void Function(Map<String, dynamic>?, TypeAlert);

enum AlertPosition { top, bottom }

class DropdownAlert extends StatefulWidget {
  const DropdownAlert({
    Key? key,
    this.onTap,
    this.successImage,
    this.warningImage,
    this.errorImage,
    this.errorBackground,
    this.successBackground,
    this.warningBackground,
    this.closeImage,
    this.titleStyle,
    this.contentStyle,
    this.maxLinesTitle,
    this.maxLinesContent,
    this.duration,
    this.delayDismiss,
    this.avoidBottomInset = false,
    this.showCloseButton,
    this.position = AlertPosition.top,
  }) : super(key: key);
  // Callback when click on alert
  final VoidCallBack? onTap;

  // Add image for success status, get from assets
  final String? successImage;

  // Add image for warning status, get from assets
  final String? warningImage;

  // Add image for error status, get from assets
  final String? errorImage;

  // Add image for close alert, get from assets
  final String? closeImage;

  // Change color background of error status
  final Color? errorBackground;

  // Change color background of success status
  final Color? successBackground;

  // Change color background of warning status
  final Color? warningBackground;

  // Change style of title
  final TextStyle? titleStyle;

  //Avoid bottom padding inset
  final bool avoidBottomInset;

  // Change style of content
  final TextStyle? contentStyle;

  // Set max line of title, default null
  final int? maxLinesTitle;

  // Set max line of content, default null
  final int? maxLinesContent;

  final int? duration;

  final int? delayDismiss;

  final bool? showCloseButton;

  // Set position of alert, default AlertPosition.TOP
  final AlertPosition? position;

  @override
  DropdownAlertWidget createState() => DropdownAlertWidget();
}

class DropdownAlertWidget extends State<DropdownAlert>
    with TickerProviderStateMixin {
  final int duration = 300;
  final int delay = 3000;
  late AnimationController? _animationController;
  // ignore: always_specify_types
  Animation<double>? _animationPush;
  Timer? _timer;
  Timer? _timerRelay;
  AlertController? _controller;
  String? title;
  String? message;
  TypeAlert? type;
  Map<String, dynamic>? payload;

  int getDuration() {
    if (widget.duration != null && widget.duration! > 0) {
      return widget.duration!;
    }
    return duration;
  }

  int? getDelay() {
    if (widget.delayDismiss != null && widget.delayDismiss! > 0) {
      return widget.delayDismiss;
    } else if (widget.delayDismiss == null) {
      return delay;
    } else if (widget.delayDismiss! <= 0) {
      return null;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _controller = AlertController();
    _controller?.setShow(show);
    _controller?.setHide(hide);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: getDuration()),
    );
    _animationPush =
        Tween<double>(begin: -180.0, end: 0.0).animate(_animationController!);
  }

  show(
    String title,
    String message,
    TypeAlert type, [
    Map<String, dynamic>? payload,
  ]) {
    final int delay = getDelay() ?? 0;
    if (!_animationController!.isDismissed) {
      cancelTimerRelay();
      cancelTimer();
      _animationController!.reverse();
      _timerRelay = Timer(Duration(milliseconds: getDuration()), () {
        setState(() {
          this.title = title;
          this.message = message;
          this.type = type;
          this.payload = payload;
        });
        _animationController!.forward();
        _timer = Timer(Duration(milliseconds: delay), () {
          _animationController!.reverse();
        });
      });
    } else {
      setState(() {
        this.title = title;
        this.message = message;
        this.type = type;
        this.payload = payload;
      });
      _animationController!.forward();
      _timer = Timer(Duration(milliseconds: delay), () {
        _animationController!.reverse();
      });
    }
  }

  hide() {
    cancelTimer();
    _animationController!.reverse();
  }

  cancelTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  cancelTimerRelay() {
    if (_timerRelay != null) {
      _timerRelay!.cancel();
    }
  }

  onPress() {
    if (widget.showCloseButton != true) {
      cancelTimer();
      hide();
    }
    if (widget.onTap != null) {
      widget.onTap!(payload!, type!);
    }
    bool? callback = _controller?.isCallbackNull();
    if (callback == false) {
      _controller?.getTabListener()(payload, type!);
    }
  }

  String? getIconUri(TypeAlert? type) {
    switch (type) {
      case TypeAlert.success:
        return widget.successImage;
      case TypeAlert.warning:
        return widget.warningImage;
      case TypeAlert.error:
        return widget.errorImage;
      default:
        return null;
    }
  }

  // Use it when Image was null
  IconData? getIcon(TypeAlert? type) {
    switch (type) {
      case TypeAlert.success:
        return Icons.check;
      case TypeAlert.warning:
        return Icons.warning_amber_outlined;
      case TypeAlert.error:
        return Icons.error_outline;
      default:
        return null;
    }
  }

  Color getBackground(TypeAlert? type) {
    switch (type) {
      case TypeAlert.success:
        return widget.successBackground ?? Colors.green;
      case TypeAlert.warning:
        return widget.warningBackground ?? const Color(0xFFCE863D);
      case TypeAlert.error:
        return widget.errorBackground ?? Colors.red;
      default:
        return Colors.green;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
    _controller = null;
    _timer!.cancel();
    _timerRelay!.cancel();
  }

  onCloseAlert() {
    hide();
  }

  void onSwipeAlert(DragStartDetails data) async {
    if (widget.showCloseButton != true) {
      hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ).merge(widget.titleStyle);
    final TextStyle contentStyle =
        const TextStyle(color: Colors.white).merge(widget.contentStyle);
    String? iconUri = getIconUri(type);
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (BuildContext c, Widget? v) => Positioned(
        top:
            widget.position == AlertPosition.top ? _animationPush!.value : null,
        bottom: widget.position == AlertPosition.bottom
            ? _animationPush!.value
            : null,
        child: GestureDetector(
          onVerticalDragStart: onSwipeAlert,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: MaterialButton(
              color: getBackground(this.type),
              padding: EdgeInsets.only(
                top: widget.position == AlertPosition.top ? 60.h : 18.h,
                bottom: 18.h +
                    (widget.avoidBottomInset
                        ? MediaQuery.of(context).padding.bottom
                        : 0),
                left: 0,
                right: 12.w,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
                side: BorderSide.none,
              ),
              onPressed: onPress,
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 26.w),
                      child: iconUri != null
                          ? SvgPicture.asset(
                              iconUri,
                              fit: BoxFit.contain,
                              height: 30.w,
                              width: 30.w,
                            )
                          : Icon(
                              getIcon(type),
                              color: Colors.white,
                              size: 34.w,
                            ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          title != ''
                              ? Text(
                                  title ?? '',
                                  style: titleStyle,
                                  maxLines: widget.maxLinesTitle,
                                )
                              : const SizedBox(),
                          SizedBox(
                            height:
                                this.title == '' || this.message == '' ? 0 : 6,
                          ),
                          this.message != ''
                              ? Text(
                                  this.message ?? '',
                                  style: contentStyle,
                                  maxLines: widget.maxLinesContent,
                                )
                              : const SizedBox()
                        ],
                      ),
                    ),
                    widget.showCloseButton == true
                        ? IconButton(
                            onPressed: onCloseAlert,
                            icon: widget.closeImage != null
                                ? Image.asset(
                                    widget.closeImage!,
                                    fit: BoxFit.contain,
                                    height: 20.w,
                                    width: 20.w,
                                  )
                                : Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 24.w,
                                  ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
