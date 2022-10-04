library custom_switch;

import 'package:flutter/material.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({
    Key? key,
    this.value,
    this.onChanged,
    this.activeColor,
    this.inactiveColor = Colors.grey,
    this.activeText = '',
    this.inactiveText = '',
    this.activeTextColor = Colors.white70,
    this.inactiveTextColor = Colors.white70,
  }) : super(key: key);
  final bool? value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color inactiveColor;
  final String activeText;
  final String inactiveText;
  final Color activeTextColor;
  final Color inactiveTextColor;

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  late Animation<AlignmentGeometry> _circleAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _circleAnimation = AlignmentTween(
      begin: widget.value! ? Alignment.centerRight : Alignment.centerLeft,
      end: widget.value! ? Alignment.centerLeft : Alignment.centerRight,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return GestureDetector(
          onTap: () {
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
            widget.value == false
                ? widget.onChanged?.call(true)
                : widget.onChanged?.call(false);
          },
          child: Stack(
            alignment: _circleAnimation.value,
            children: <Widget>[
              Container(
                alignment: _circleAnimation.value,
                width: 30.0,
                height: 13.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: ColorsConstant.cFFABADBA,
                  gradient: _circleAnimation.value == Alignment.centerRight
                      ? ColorsConstant.appPrimaryGradient
                      : null,
                ),
              ),
              Container(
                width: 19.w,
                height: 19.w,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorsConstant.cFFE3E4E8, width: 2),
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
