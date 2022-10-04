import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/data/model/invoice_model.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
import 'package:passenger/features/trip_detail/presentation/bloc/util/extension.dart';
import 'package:passenger/features/trip_detail/presentation/widget/divider_widget.dart';
import 'package:passenger/features/trip_detail/presentation/widget/title_and_value_widget.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/string_constant.dart';
import 'package:passenger/util/styles.dart';

class BookingInfoWidget extends StatelessWidget {
  const BookingInfoWidget({
    Key? key,
    required this.invoice,
    required this.booking,
  }) : super(key: key);
  final InvoiceData invoice;
  final BookingData booking;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsConstant.cWhite,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 24.w),
            child: Column(
              children: <Widget>[
                TitleAndValueWidget(
                  title: booking.carInfo?.carType?.typeName?.validValue() ??
                      StringConstant.mockNullString,
                  value: booking.carInfo?.carType?.price?.validValue() ??
                      StringConstant.mockNullString,
                ),
                TitleAndValueWidget(
                  title: S(context).expressway,
                  value: invoice.booking!.expressWayFee?.validValue() ??
                      StringConstant.mockNullString,
                ),
              ],
            ),
          ),
          const DividerWidget(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 24.w),
            child: Column(
              children: <Widget>[
                TitleAndValueWidget(
                  title: S(context).subtotal,
                  value: invoice.booking!.price?.validValue() ??
                      StringConstant.mockNullString,
                ),
                SizedBox(height: 8.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          S(context).promo,
                          style: StylesConstant.ts16w500.copyWith(
                            color: ColorsConstant.cFFA33AA3,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          S(context).newuser,
                          style: StylesConstant.ts16w400.copyWith(
                            color: ColorsConstant.cFFA33AA3,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      invoice.booking!.promotionAmount?.validValue() ??
                          StringConstant.mockNullString,
                      style: StylesConstant.ts16w500
                          .copyWith(color: ColorsConstant.cFFA33AA3),
                    )
                  ],
                )
              ],
            ),
          ),
          const DividerWidget(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 24.w),
            child: TitleAndValueWidget(
              title: S(context).total,
              titleStyle: StylesConstant.ts16w500
                  .copyWith(color: ColorsConstant.cFFA33AA3),
              value:
                  '''฿${invoice.booking?.totalAmountIncludeTip?.validValue() ?? StringConstant.mockNullString}''',
              valueStyle: StylesConstant.ts20w500
                  .copyWith(color: ColorsConstant.cFFA33AA3),
            ),
          ),
        ],
      ),
    );
  }
}
