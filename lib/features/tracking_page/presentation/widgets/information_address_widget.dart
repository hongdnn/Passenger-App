import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/data/model/upsert_draft_booking_model.dart';
import 'package:passenger/features/tracking_page/presentation/widgets/payment_infor_widget.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/date_util.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/string_constant.dart';
import 'package:passenger/util/styles.dart';

class InformationAddressWidget extends StatelessWidget {
  const InformationAddressWidget({
    Key? key,
    required this.listLocationRequest,
    required this.price,
    this.advancedBookingTime,
  }) : super(key: key);

  final List<LocationRequest>? listLocationRequest;
  final double? price;
  final DateTime? advancedBookingTime;

  @override
  Widget build(BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorsConstant.cFFE3E4E8),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      margin: EdgeInsets.symmetric(horizontal: 24.w)
          .copyWith(top: 24.h, bottom: 16.h),
      child: Column(
        children: <Widget>[
          advancedBookingTime != null
              ? Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          S(context).schedule_a_ride_for_title,
                          style: StylesConstant.ts16w400,
                        ),
                        Text(
                          DateUtil.formatDateTimeForBooking(
                            locale,
                            advancedBookingTime!,
                          ),
                          style: StylesConstant.ts16w500
                              .copyWith(color: ColorsConstant.cFFA33AA3),
                        )
                      ],
                    ),
                    const Divider(),
                  ],
                )
              : const SizedBox.shrink(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _destinationPins(),
              SizedBox(width: 15.w),
              Expanded(child: _destinationInfos()),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          const Divider(),
          PaymentInforWidget(
            key: const ValueKey<String>('tracking-page-payment-info'),
            price: price,
          )
        ],
      ),
    );
  }

  Widget _destinationPins() {
    List<Widget> pins = <Widget>[];
    pins.add(
      SvgPicture.asset(SvgAssets.icPin),
    );

    if (listLocationRequest!.length <= minDestinationLength) {
      pins.add(
        Column(
          children: <Widget>[
            Container(
              height: 24.h,
              padding: EdgeInsets.all(5.h),
              child: SvgPicture.asset(SvgAssets.icStripedLines),
            ),
            SvgPicture.asset(SvgAssets.icPinDestination),
          ],
        ),
      );
    } else {
      for (int i = minDestinationLength - 1;
          i < listLocationRequest!.length;
          i++) {
        pins.add(
          Column(
            children: <Widget>[
              Container(
                height: 24.h,
                padding: EdgeInsets.all(5.h),
                child: SvgPicture.asset(SvgAssets.icStripedLines),
              ),
              SvgPicture.asset(StringConstant.iconDestination[i]!),
            ],
          ),
        );
      }
    }
    return Column(
      children: pins,
    );
  }

  Widget _destinationInfos() {
    List<Widget> infos = <Widget>[];
    infos.add(_destinationItem(listLocationRequest![0]));
    for (int i = 1; i < listLocationRequest!.length; i++) {
      infos
        ..add(
          SizedBox(height: 20.h),
        )
        ..add(_destinationItem(listLocationRequest![i]));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: infos,
    );
  }

  Widget _destinationItem(LocationRequest locationModel) {
    return Text(
      '${locationModel.address}',
      style: StylesConstant.ts16w400,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
