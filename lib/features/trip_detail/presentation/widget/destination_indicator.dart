import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passenger/features/trip_detail/presentation/bloc/util/extension.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/string_constant.dart';
import 'package:passenger/util/styles.dart';

import '../../../landing_page/data/common_model/common_model.dart';

class DestinationIndicator extends StatelessWidget {
  const DestinationIndicator({
    Key? key,
    required this.finishLocations,
    this.isDisplayArrivedTime = false,
  }) : super(key: key);
  final List<TripLocation> finishLocations;
  final bool isDisplayArrivedTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsConstant.cWhite,
      padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 24.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildIndicator(finishLocations),
          SizedBox(
            width: 12.w,
          ),
          Expanded(child: _destinationDetail())
        ],
      ),
    );
  }

  Widget _buildIndicator(List<TripLocation> finishLocations) {
    List<Widget> widgets = <Widget>[];
    widgets.add(
      Padding(
        padding: EdgeInsets.only(top: 10.w),
        child: SvgPicture.asset(SvgAssets.icPin),
      ),
    );

    for (int i = 1; i < finishLocations.length; i++) {
      widgets
        ..add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.w),
            child: SvgPicture.asset(SvgAssets.icTripleLine),
          ),
        )
        ..add(
          SvgPicture.asset(SvgAssets.icLocationFill),
        );
    }

    return Column(children: widgets);
  }

  Widget _destinationDetail() {
    List<Widget> widgets = <Widget>[];
    widgets.add(_buildDestinationItem(finishLocations[0]));
    for (int i = 1; i < finishLocations.length; i++) {
      widgets
        ..add(SizedBox(height: 15.h))
        ..add(_buildDestinationItem(finishLocations[i]));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Widget _buildDestinationItem(TripLocation data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        isDisplayArrivedTime == true
            ? const SizedBox.shrink()
            : SizedBox(
                height: 14.h,
              ),
        Text(
          '''${data.addressName?.fitTextToScreen()?.validValue() ?? StringConstant.mockNullString} • ${data.address?.validValue() ?? StringConstant.mockNullString}''',
          style: StylesConstant.ts16w400,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        isDisplayArrivedTime == true
            ? Text(
                data.arrivedTime?.isNotEmpty == true
                    ? formatTimeThailand(
                        data.arrivedTime!,
                      ).validValue()
                    : StringConstant.mockNullString,
                style: StylesConstant.ts14w400.copyWith(
                  color: ColorsConstant.cFF73768C,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
            : const SizedBox()
      ],
    );
  }
}
