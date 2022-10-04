import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:passenger/features/booking_page/data/model/invoice_model.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
import 'package:passenger/features/trip_detail/presentation/bloc/util/extension.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/string_constant.dart';
import 'package:passenger/util/styles.dart';

class DriverInfoWidget extends StatelessWidget {
  const DriverInfoWidget({Key? key, required this.invoice}) : super(key: key);
  final InvoiceData invoice;

  @override
  Widget build(BuildContext context) {
    BookingData booking = invoice.booking!;
    String liscence = booking.carInfo?.licensePlateNumber?.validValue() ??
        StringConstant.mockNullString;
    String region =
        booking.carInfo?.region?.validValue() ?? StringConstant.mockNullString;
    String branch =
        booking.carInfo?.branch?.validValue() ?? StringConstant.mockNullString;

    return Container(
      color: ColorsConstant.cWhite,
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 14.w,
      ),
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: invoice.booking!.driverInfo?.avatar?.isNotEmpty == true
                    ? CachedNetworkImage(
                        errorWidget: (BuildContext context, String url, _) =>
                            Image.asset(
                          PngAssets.mockThumbnail,
                        ),
                        placeholder: (BuildContext context, String url) =>
                            const CircularProgressIndicator(),
                        imageUrl: invoice.booking!.driverInfo?.avatar ?? '',
                        height: 40.w,
                        width: 40.w,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        PngAssets.mockThumbnail,
                        height: 40.w,
                        width: 40.w,
                        fit: BoxFit.cover,
                      ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  PngAssets.icProtectDriver,
                  height: 16.w,
                  width: 16.w,
                ),
              )
            ],
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                invoice.booking!.driverInfo?.name?.validValue() ??
                    StringConstant.mockNullString,
                style: StylesConstant.ts14w400,
              ),
              Text(
                '$liscence • $region • $branch',
                style: StylesConstant.ts14w400,
              )
            ],
          )
        ],
      ),
    );
  }
}
