import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/features/booking_page/data/model/upsert_draft_booking_model.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/string_constant.dart';
import 'package:passenger/util/styles.dart';

class TripLocationInfoWidget extends StatelessWidget {
  const TripLocationInfoWidget({
    Key? key,
    required this.tripLocation,
  }) : super(key: key);
  final List<TripLocation> tripLocation;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _destinationPins(),
        SizedBox(width: 15.w),
        Expanded(child: _destinationInfos()),
      ],
    );
  }

  Widget _destinationPins() {
    List<Widget> pins = <Widget>[];
    pins.add(
      SvgPicture.asset(SvgAssets.icPin),
    );

    if (tripLocation.length <= minDestinationLength) {
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
      for (int i = minDestinationLength - 1; i < tripLocation.length; i++) {
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
    infos.add(
      _destinationItem(
        LocationRequest.fromTripLocation(
          tripLocation[0],
        ),
      ),
    );
    for (int i = 1; i < tripLocation.length; i++) {
      infos
        ..add(
          SizedBox(height: 20.h),
        )
        ..add(
          _destinationItem(
            LocationRequest.fromTripLocation(
              tripLocation[i],
            ),
          ),
        );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: infos,
    );
  }

  Widget _destinationItem(LocationRequest locationModel) {
    return Text(
      '${locationModel.addressName} • ${locationModel.address}',
      style: StylesConstant.ts16w400,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
