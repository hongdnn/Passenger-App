import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/data/model/booking_order_model.dart';
import 'package:passenger/features/booking_page/data/model/cancel_booking_model.dart';
import 'package:passenger/features/booking_page/presentation/bloc/booking_page_bloc.dart';
import 'package:passenger/features/booking_page/presentation/cancel_booking_page.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
import 'package:passenger/features/sendbird_chat/presentation/conversation_page.dart';
import 'package:passenger/features/tracking_page/data/model/driver_accept_booking_model.dart';
import 'package:passenger/features/tracking_page/presentation/bloc/tracking_page_bloc.dart';
import 'package:passenger/features/tracking_page/presentation/widgets/tracking_slider_widget.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/string_constant.dart';
import 'package:passenger/util/styles.dart';
import 'package:passenger/util/util.dart';
import 'package:passenger/util/widgets/custom_dialog.dart';
import 'package:share_plus/share_plus.dart';

final ValueNotifier<double> valueSlider = ValueNotifier<double>(20);

class TrackingProgressWidget extends StatefulWidget {
  const TrackingProgressWidget({
    Key? key,
    required this.driverAcceptBookingModel,
    required this.bookingOrderModel,
  }) : super(key: key);
  final DriverAcceptBookingModel driverAcceptBookingModel;
  final BookingOrderModel bookingOrderModel;

  @override
  State<TrackingProgressWidget> createState() => _TrackingProgressWidgetState();
}

class _TrackingProgressWidgetState extends State<TrackingProgressWidget> {
  String getStatusBooking(BookingStatus? bookingStatus, BuildContext context) {
    switch (bookingStatus) {
      case BookingStatus.driverFound:
        return S(context).driver_found;
      case BookingStatus.driverAlmostArrive:
        return S(context).the_driver_is_almost_there;
      case BookingStatus.driverArrive:
        return S(context).the_driver_is_here;
      case BookingStatus.driverPickUp:
        return S(context).im_on_my_way;
      case BookingStatus.completed:
        return S(context).im_arrived;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Column(
        children: <Widget>[
          BlocListener<TrackingPageBloc, TrackingPageState>(
            listener: (_, TrackingPageState state) {
              if (state.bookingStatus == BookingStatus.searching) {
                valueSlider.value = 20;
              } else if (state.bookingStatus == BookingStatus.driverFound) {
                valueSlider.value = 20;
              } else if (state.bookingStatus ==
                  BookingStatus.driverAlmostArrive) {
                valueSlider.value = 40;
              } else if (state.bookingStatus == BookingStatus.driverArrive) {
                valueSlider.value = 60;
              } else if (state.bookingStatus == BookingStatus.driverPickUp) {
                valueSlider.value = 80;
              } else if (state.bookingStatus ==
                  BookingStatus.dropOffMidDestination) {
                valueSlider.value = 100;
              }
            },
            child: ValueListenableBuilder<double>(
              valueListenable: valueSlider,
              builder: (_, double newValue, Widget? error) {
                return TrackingSliderWidget(
                  value: valueSlider,
                );
              },
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          _buildRemainingTimeWidget(context),
          _buildDivider(),
          _buildBottomWidget(context, widget.driverAcceptBookingModel),
          // _buildRouteWidget()
        ],
      ),
    );
  }

  _buildPaymentWidget(
    BuildContext context,
    DriverAcceptBookingModel driverAcceptBookingModel,
  ) {
    final double price =
        (driverAcceptBookingModel.data?.price ?? 0).toPrecision() -
            (driverAcceptBookingModel.data?.promotionAmount ?? 0).toPrecision();
    return <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            S(context).total,
            style: StylesConstant.ts16w400,
          ),
          Text(
            '฿${price.toPrecision().toString()}',
            style: StylesConstant.ts16w500,
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                S(context).payment_methods,
                style: StylesConstant.ts16w400,
              ),
              SizedBox(
                width: 5.w,
              ),
              SvgPicture.asset(SvgAssets.icPaymentVisa),
            ],
          ),
          Text('My card ***9999', style: StylesConstant.ts16w500)
        ],
      )
    ];
  }

  Widget _buildDivider() {
    return const Divider();
  }

  Widget _buildRemainingTimeWidget(BuildContext context) {
    return BlocBuilder<BookingPageBloc, BookingPageState>(
      builder: (_, BookingPageState stateBooking) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocBuilder<TrackingPageBloc, TrackingPageState>(
            builder: (_, TrackingPageState state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    getStatusBooking(state.bookingStatus, context),
                    style: StylesConstant.ts16w400
                        .copyWith(color: ColorsConstant.cFFA33AA3),
                  ),
                  Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        SvgAssets.icClock,
                        color: ColorsConstant.cFF454754,
                        height: 16.w,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        '10 mins left',
                        style: StylesConstant.ts14w400
                            .copyWith(color: ColorsConstant.cFF454754),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildDriverInfoWidget(
    BuildContext context,
  ) {
    return BlocBuilder<TrackingPageBloc, TrackingPageState>(
      builder: (_, TrackingPageState state) {
        CarInfo carInfo =
            state.driverAcceptBookingModel?.data?.carInfo ?? CarInfo();
        DriverInfo driverInfoAccepted =
            state.driverAcceptBookingModel?.data?.driverInfo ?? DriverInfo();
        if (<BookingStatus>[
          BookingStatus.driverFound,
          BookingStatus.driverAlmostArrive,
          BookingStatus.driverArrive,
          BookingStatus.driverPickUp,
          BookingStatus.confirmed,
          BookingStatus.dropOffMidDestination,
          BookingStatus.dropOffMidDestination
        ].any((BookingStatus element) => element == state.bookingStatus)) {
          return Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        SizedBox(
                          height: 40.w,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              width: 40.w,
                              height: 40.w,
                              imageUrl: driverInfoAccepted.avatar ?? '',
                              errorWidget: (_, __, ___) =>
                                  const CupertinoActivityIndicator(),
                              fit: BoxFit.fill,
                              httpHeaders: const <String, String>{
                                'Authorization': ggStorageToken,
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          left: 26.w,
                          child: CachedNetworkImage(
                            imageUrl: carInfo.icon ?? '',
                            width: 69.w,
                            errorWidget: (_, __, ___) =>
                                const CupertinoActivityIndicator(),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      driverInfoAccepted.name ?? '',
                      style: StylesConstant.ts14w500
                          .copyWith(color: ColorsConstant.cFF454754),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          driverInfoAccepted.rating.toString(),
                          style: StylesConstant.ts14w400
                              .copyWith(color: ColorsConstant.cFFA33AA3),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        SvgPicture.asset(
                          SvgAssets.icStarSelected,
                          height: 13.w,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          onTap: () =>
                              urlSchemaUtil(' 027777564', UrlSchemaType.phone),
                          child: SvgPicture.asset(
                            SvgAssets.icPhone,
                            height: 20.w,
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              ConversationPage.routeName,
                              arguments: ConversationArg(
                                driverId: driverInfoAccepted.driverId ?? '',
                                driverName: driverInfoAccepted.name ?? '',
                              ),
                            );
                          },
                          child: SvgPicture.asset(
                            SvgAssets.icMessage,
                            height: 20.w,
                          ),
                        ),
                        <BookingStatus>[
                          BookingStatus.driverPickUp,
                        ].any(
                          (BookingStatus element) =>
                              element == state.bookingStatus,
                        )
                            ? SizedBox(
                                width: 20.w,
                              )
                            : const SizedBox.shrink(),
                        <BookingStatus>[
                          BookingStatus.driverPickUp,
                        ].any(
                          (BookingStatus element) =>
                              element == state.bookingStatus,
                        )
                            ? GestureDetector(
                                onTap: () {
                                  _shareFunction();
                                },
                                child: SvgPicture.asset(
                                  SvgAssets.icShared,
                                  height: 20.w,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      carInfo.licensePlateNumber.toString(),
                      style: StylesConstant.ts20w500
                          .copyWith(color: ColorsConstant.cFFA33AA3),
                    ),
                    Text(
                      carInfo.region.toString(),
                      style: StylesConstant.ts14w400,
                    ),
                    Text(
                      carInfo.branch.toString(),
                      style: StylesConstant.ts14w400,
                    ),
                  ],
                ),
              )
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  _buildRouteWidget(Trip tripAccepted) {
    return <Widget>[
      Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SvgPicture.asset(
                    SvgAssets.icPin,
                    height: 24.h,
                    width: 24.w,
                  ),
                  SizedBox(
                    height: 5.5.h,
                  ),
                  SvgPicture.asset(
                    SvgAssets.icStripedLines,
                    height: 8.h,
                    width: 2.w,
                  ),
                  SizedBox(
                    height: 5.5.h,
                  ),
                  SvgPicture.asset(
                    SvgAssets.icPinDestination,
                    height: 24.h,
                    width: 24.w,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 12.w,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  tripAccepted.locations![0].address.toString(),
                  style: StylesConstant.ts16w400.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 18.h,
                ),
                Text(
                  tripAccepted
                      .locations![tripAccepted.locations!.length - 1].address
                      .toString(),
                  style: StylesConstant.ts16w400.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      SizedBox(
        height: 8.h,
      ),
      const Divider()
    ];
  }

  Widget _buildBottomWidget(
    BuildContext context,
    DriverAcceptBookingModel model,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            _buildDriverInfoWidget(
              context,
            ),
            _buildDivider(),
            ..._buildRouteWidget(model.data!.trip!),
            ..._buildPaymentWidget(context, model),
            _buildDivider(),
            _buildCancelButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return BlocBuilder<TrackingPageBloc, TrackingPageState>(
      builder: (BuildContext context, TrackingPageState trackingPageState) {
        bool isShowEmergencyButton = <BookingStatus>[
          BookingStatus.driverPickUp,
        ].any(
          (BookingStatus element) => element == trackingPageState.bookingStatus,
        );
        return GestureDetector(
          onTap: () {
            isShowEmergencyButton
                ? urlSchemaUtil(' 027777564', UrlSchemaType.phone)
                : showCustomDialog(
                    context: context,
                    options: CustomDialogParams(
                      title: S(context).confirm_cancel,
                      message: S(context).message_confirm_cancel,
                      positiveParams: CustomDialogButtonParams(
                        title: S(context).confirm,
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            CancelBooking.routeName,
                            arguments: CancelBookingBody(
                              id: widget.bookingOrderModel.data?.id ?? '',
                              userId:
                                  widget.bookingOrderModel.data?.userId ?? '',
                            ),
                          );
                        },
                        hasGradient: true,
                      ),
                      negativeParams: CustomDialogButtonParams(
                        title: S(context).go_back,
                        onPressed: () {},
                      ),
                    ),
                  );
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Text(
              isShowEmergencyButton
                  ? S(context).emergency_call
                  : S(context).cancel_reservation,
              style: isShowEmergencyButton
                  ? StylesConstant.ts16w500
                      .copyWith(color: ColorsConstant.cFFA33AA3)
                  : StylesConstant.ts16w500,
            ),
          ),
        );
      },
    );
  }

  void _shareFunction() {
    Share.share(
      'check out my website http://maps.ridehailing.com',
      subject: 'Robinhood\nmaps.ridehailing.com',
    );
  }
}
