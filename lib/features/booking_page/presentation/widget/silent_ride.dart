import 'package:flutter/cupertino.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';

class SilentRide extends StatelessWidget {
  const SilentRide({
    Key? key,
    required this.valueSilentRide,
  }) : super(key: key);

  final ValueNotifier<bool> valueSilentRide;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: valueSilentRide,
      builder: (BuildContext context, bool isSilentRide, Widget? child) =>
          Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              S(context).silent_ride,
              style: StylesConstant.ts16w500.copyWith(
                color: ColorsConstant.cFF454754,
              ),
            ),
            SizedBox(
              height: 24.h,
              width: 44.w,
              child: Transform.scale(
                transformHitTests: false,
                scale: 0.8,
                child: CupertinoSwitch(
                  activeColor: ColorsConstant.cFF7A4BC9,
                  value: isSilentRide,
                  onChanged: (bool value) {
                    valueSilentRide.value = value;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
