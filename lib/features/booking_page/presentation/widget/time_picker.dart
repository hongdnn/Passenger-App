import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/date_util.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';
import 'package:passenger/util/widgets/custom_dialog.dart';
import 'package:passenger/util/widgets/show_modal_bottom_sheet.dart';
import 'package:passenger/util/widgets/time_picker_widget.dart';

class TimePickerContent extends StatefulWidget {
  const TimePickerContent({
    Key? key,
    required this.bookingAdvanceAnimation,
    required this.selectedDateTime,
  }) : super(key: key);

  final Animation<double> bookingAdvanceAnimation;
  final ValueNotifier<DateTime?> selectedDateTime;

  @override
  State<TimePickerContent> createState() => _TimePickerContentState();
}

class _TimePickerContentState extends State<TimePickerContent> {
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: widget.bookingAdvanceAnimation,
      child: InkWell(
        onTap: () {
          showCustomModalBottomSheet(
            context: context,
            backgroundColor: ColorsConstant.cWhite,
            content: TimePickerWidget(
              onPickedTime: (DateTime pickedTime) {
                if (pickedTime.millisecondsSinceEpoch <
                    DateTime.now()
                        .add(const Duration(minutes: 59))
                        .millisecondsSinceEpoch) {
                  showCustomDialog(
                    context: context,
                    options: CustomDialogParams(
                      title: S(context).cannot_reserved,
                      message: S(context).booking_time_err_msg,
                      positiveParams: CustomDialogButtonParams(
                        hasGradient: true,
                        title: S(context).agree,
                      ),
                    ),
                  );
                  return;
                }
                widget.selectedDateTime.value = pickedTime;
                Navigator.pop(context);
              },
              isFirstTime: widget.selectedDateTime.value == null,
              initialDateTime: widget.selectedDateTime.value ?? DateTime.now(),
            ),
          );
        },
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Text(
                  S(context).choose_time,
                  style: StylesConstant.ts20w500.copyWith(fontSize: 18),
                ),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ValueListenableBuilder<DateTime?>(
                      valueListenable: widget.selectedDateTime,
                      builder: (
                        _,
                        DateTime? selectedDateTime,
                        __,
                      ) {
                        final DateTime? dateTime =
                            widget.selectedDateTime.value;
                        if (dateTime == null) {
                          return const SizedBox();
                        }
                        String locale =
                            Localizations.localeOf(context).languageCode;
                        final String formattedDateTime =
                            DateUtil.formatDateTimeForBooking(locale, dateTime);
                        return Flexible(
                          child: Text(
                            formattedDateTime,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: StylesConstant.ts16w400,
                          ),
                        );
                      },
                    ),
                    const Icon(CupertinoIcons.chevron_forward)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
