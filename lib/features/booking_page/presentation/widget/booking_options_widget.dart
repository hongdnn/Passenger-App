import 'package:flutter/material.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/util/size.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/app_config/get_it/getit_config.dart';
import '../../../../util/widgets/custom_button.dart';

const int instantIndex = 0;
const int bookInAdvanceIndex = 1;

class BookingOptionsWidget extends StatefulWidget {
  const BookingOptionsWidget({Key? key, this.onOptionChanged})
      : super(key: key);
  final Function(int index)? onOptionChanged;

  @override
  BookingOptionsWidgetState createState() => BookingOptionsWidgetState();
}

class BookingOptionsWidgetState extends State<BookingOptionsWidget> {
  final ValueNotifier<bool> _isFirstBtnSelected = ValueNotifier<bool>(
    getIt<SharedPreferences>().getBool('isBookingNow') ?? true,
  );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isFirstBtnSelected,
      builder: (_, bool newValue, Widget? error) {
        return Container(
          padding: EdgeInsets.only(left: 24.w),
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  if (!_isFirstBtnSelected.value) {
                    widget.onOptionChanged?.call(instantIndex);
                    _isFirstBtnSelected.value = !_isFirstBtnSelected.value;
                  }
                },
                child: CustomButton(
                  params: _isFirstBtnSelected.value
                      ? CustomButtonParams.primary(
                          text: S(context).book_now,
                        ).copyWith(
                          padding: EdgeInsets.symmetric(
                            vertical: 4.w,
                            horizontal: 8.w,
                          ),
                        )
                      : CustomButtonParams.primaryUnselected(
                          text: S(context).book_now,
                        ).copyWith(
                          padding: EdgeInsets.symmetric(
                            vertical: 4.w,
                            horizontal: 8.w,
                          ),
                        ),
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              InkWell(
                onTap: () {
                  if (_isFirstBtnSelected.value) {
                    widget.onOptionChanged?.call(bookInAdvanceIndex);
                    _isFirstBtnSelected.value = !_isFirstBtnSelected.value;
                  }
                },
                child: CustomButton(
                  params: !_isFirstBtnSelected.value
                      ? CustomButtonParams.primary(
                          text: S(context).book_in_advance,
                        ).copyWith(
                          padding: EdgeInsets.symmetric(
                            vertical: 4.w,
                            horizontal: 8.w,
                          ),
                        )
                      : CustomButtonParams.primaryUnselected(
                          text: S(context).book_in_advance,
                        ).copyWith(
                          padding: EdgeInsets.symmetric(
                            vertical: 4.w,
                            horizontal: 8.w,
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
