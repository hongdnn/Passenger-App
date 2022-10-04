import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passenger/core/util/localization.dart';
export 'package:passenger/core/util/localization.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';
import 'package:passenger/util/widgets/custom_button.dart';
import 'package:passenger/util/widgets/custom_time_picker.dart';

//ignore: must_be_immutable
class TimePickerWidget extends StatelessWidget {
  TimePickerWidget({
    Key? key,
    required this.onPickedTime,
    required this.initialDateTime,
    this.onTimeChange,
    this.isFirstTime = false,
  }) : super(key: key);

  final Function(DateTime)? onTimeChange;
  final Function(DateTime) onPickedTime;
  late DateTime initialDateTime;
  bool isFirstTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                S(context).choose_time,
                textAlign: TextAlign.start,
                style: StylesConstant.ts20w500,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: SvgPicture.asset(
                  SvgAssets.icClose,
                  width: 14.w,
                  height: 14.w,
                ),
              )
            ],
          ),
        ),
        const Divider(
          height: 2,
          thickness: 1.5,
        ),
        TimePickerSpinner(
          is24HourMode: true,
          normalTextStyle:
              StylesConstant.ts16w400.copyWith(color: ColorsConstant.cFFABADBA),
          highlightedTextStyle:
              StylesConstant.ts16w400.copyWith(color: ColorsConstant.cFFA33AA3),
          spacing: 20.h,
          itemHeight: 80.h,
          itemWidth: 100.w,
          time: initialDateTime,
          minutesInterval: 15,
          isFirstTime: isFirstTime,
          onTimeChange: (DateTime time) {
            initialDateTime = time;
            onTimeChange?.call(time);
          },
        ),
        SafeArea(
          top: false,
          child: Container(
            margin: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 10.h,
              bottom: 16.h,
            ),
            child: CustomButton(
              params: CustomButtonParams.primary(
                text: S(context).confirm,
                onPressed: () {
                  onPickedTime.call(initialDateTime);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
