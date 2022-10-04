import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
import 'package:passenger/features/landing_page/data/model/like_request_model.dart';
import 'package:passenger/features/landing_page/presentation/bloc/landing_page_bloc.dart';
import 'package:passenger/features/booking_page/presentation/booking_page.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/string_constant.dart';
import 'package:passenger/util/styles.dart';

class DraftBookingWidget extends StatefulWidget {
  const DraftBookingWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final BookingData data;

  @override
  State<DraftBookingWidget> createState() => _DraftBookingWidgetState();
}

class _DraftBookingWidgetState extends State<DraftBookingWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          BookingPage.routeName,
          arguments: BookingArg(
            bookingLocationList: null,
            reorderBookingData: widget.data,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 28.w, left: 1, top: 2, bottom: 1),
        padding: EdgeInsets.all(16.w),
        width: 300.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.w)),
          color: Colors.white,
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              offset: Offset(1, 1),
              blurRadius: 0.0001,
            ),
            BoxShadow(
              color: Colors.black12,
              offset: Offset(-1, -1),
              blurRadius: 0.0001,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 40.h,
                  height: 40.h,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: ColorsConstant.cFFF6E5F6,
                  ),
                  padding: EdgeInsets.all(8.w),
                  child: SvgPicture.asset(SvgAssets.icCar),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.data.carInfo?.carType?.typeName ?? '',
                        maxLines: 1,
                        style: StylesConstant.ts14w500,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.data.carInfo?.createdAt?.isNotEmpty == true
                            ? buildDateInLocale(
                                inputString: widget.data.carInfo!.createdAt!,
                                context: context,
                              )
                            : '',
                        maxLines: 1,
                        style: StylesConstant.ts14w400.copyWith(
                          color: ColorsConstant.cFF73768C,
                        ),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<LandingPageBloc>(context).add(
                        SetLikeForBookingEvent(
                          LikeRequestModel(
                            isLike: !(widget.data.isLiked ?? false),
                          ),
                          widget.data.id ?? '',
                        ),
                      );
                    },
                    child: widget.data.isLiked == true
                        ? SvgPicture.asset(SvgAssets.icHeart)
                        : SvgPicture.asset(SvgAssets.icHeartBorder),
                  ),
                )
              ],
            ),
            Container(
              width: double.maxFinite,
              height: 1,
              margin: EdgeInsets.only(top: 16.h),
              color: ColorsConstant.cFFF7F7F8,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: double.maxFinite,
                    child: Text(
                      'การเดินทาง',
                      style: StylesConstant.ts16w500,
                      maxLines: 1,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    width: double.maxFinite,
                    child: ShaderMask(
                      blendMode: BlendMode.srcATop,
                      shaderCallback: (Rect bounds) => ColorsConstant
                          .appPrimaryGradient
                          .createShader(bounds),
                      child: Text(
                        'เรียกอีกครั้ง',
                        style: StylesConstant.ts14w500,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _destinationPin(),
                  SizedBox(
                    width: 14.w,
                  ),
                  Expanded(
                    child: _destinationInfo(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _destinationPin() {
    return Column(
      children: <Widget>[
        Flexible(child: SvgPicture.asset(SvgAssets.icPin)),
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(top: 3.h, bottom: 3.h),
            child: SvgPicture.asset(SvgAssets.icStripedLines),
          ),
        ),
        Flexible(child: _destinationSvgPicture()),
      ],
    );
  }

  SvgPicture _destinationSvgPicture() {
    final int milestone = widget.data.trip?.locations?.last.milestone ??
        DestinationMileStone.one.value;
    if (milestone == DestinationMileStone.two.value) {
      return SvgPicture.asset(SvgAssets.icSecondDestination);
    } else if (milestone == DestinationMileStone.three.value) {
      return SvgPicture.asset(SvgAssets.icFinalDestination);
    } else {
      return SvgPicture.asset(SvgAssets.icLocationFill);
    }
  }

  Widget _destinationInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: Text(
            widget.data.trip?.locations?[0].addressName ?? '',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        Flexible(
          child: Text(
            widget.data.trip?.locations?[0].address ?? '',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: StylesConstant.ts12w400.copyWith(
              color: ColorsConstant.cFF73768C,
            ),
          ),
        ),
        SizedBox(
          height: 6.w,
        ),
        Flexible(
          child: Text(
            widget
                    .data
                    .trip
                    ?.locations?[widget.data.trip!.locations!.length - 1]
                    .addressName ??
                '',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        Flexible(
          child: Text(
            widget
                    .data
                    .trip
                    ?.locations?[widget.data.trip!.locations!.length - 1]
                    .address ??
                '',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: StylesConstant.ts12w400.copyWith(
              color: ColorsConstant.cFF73768C,
            ),
          ),
        )
      ],
    );
  }
}
