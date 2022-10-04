import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passenger/features/landing_page/data/model/booking_history_sort_by_time_model.dart';
import 'package:passenger/features/location/data/model/location_address_model.dart';
import 'package:passenger/features/location/presentation/widget/location_picker_page.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';

class LastBookingWidget extends StatelessWidget {
  const LastBookingWidget({Key? key, required this.data}) : super(key: key);
  final BookingDataSortByTime data;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          LocationPickerPage.routeName,
          arguments: LocationPickerArg(
            bookingLocation: LocationAddressModel(
              formatAddress: data.address,
              nameAddress: data.addressName,
              latitude: data.latitude,
              longitude: data.longitude,
              placeId: data.googleId,
              reference: data.referenceId,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 40.w,
              width: 40.w,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: ColorsConstant.cFFF7F7F8,
                borderRadius: BorderRadius.all(Radius.circular(8.w)),
              ),
              child: SvgPicture.asset(
                SvgAssets.icClock,
                color: ColorsConstant.cFF73768C,
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    width: double.maxFinite,
                    child: Text(
                      data.addressName ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: StylesConstant.ts16w500,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: double.maxFinite,
                    child: Text(
                      data.address ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: StylesConstant.ts14w400,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
