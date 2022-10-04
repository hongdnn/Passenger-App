import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';
import 'package:passenger/util/widgets/time_picker_widget.dart';

class TipPaymentInProgress extends StatefulWidget {
  const TipPaymentInProgress({Key? key}) : super(key: key);

  @override
  State<TipPaymentInProgress> createState() => _TipPaymentInProgressState();
}

class _TipPaymentInProgressState extends State<TipPaymentInProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      upperBound: 0.5,
    )..repeat();
  }

  @override 
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsConstant.cWhite,
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 58.h),
        child: Column(
          children: <Widget>[
            RotationTransition(
              turns: Tween<double>(begin: 0.0, end: 1.0).animate(_controller),
              child: SvgPicture.asset(
                SvgAssets.icTimeClock,
                height: 148.h,
              ),
            ),
            SizedBox(
              height: 70.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 82.w),
              child: Text(
                S(context).payment_message,
                textAlign: TextAlign.center,
                style: StylesConstant.ts20w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
