import 'package:flutter/material.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/date_util.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';

class AdvancedBookingTimeContent extends StatelessWidget {
  const AdvancedBookingTimeContent({
    Key? key,
    required this.advancedBookingTime,
  }) : super(key: key);

  final DateTime advancedBookingTime;

  @override
  Widget build(BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w)
              .copyWith(top: 24.w, bottom: 8.w),
          child: Text(
            S(context).schedule_a_ride_for_header,
            style: StylesConstant.ts16w500,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.w),
          color: ColorsConstant.cWhite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                S(context).schedule_a_ride_for_title,
                style: StylesConstant.ts16w400,
              ),
              Text(
                DateUtil.formatDateTimeForBooking(
                  locale,
                  advancedBookingTime,
                ),
                style: StylesConstant.ts16w500,
              )
            ],
          ),
        )
      ],
    );
  }
}
