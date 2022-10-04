import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/data/model/booking_order_model.dart';
import 'package:passenger/features/booking_page/data/model/payment_method_model.dart';
import 'package:passenger/features/booking_page/presentation/bloc/booking_page_bloc.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
import 'package:passenger/features/landing_page/presentation/bloc/landing_page_bloc.dart';
import 'package:passenger/features/sendbird_chat/presentation/conversation_page.dart';
import 'package:passenger/features/tracking_page/data/model/driver_accept_booking_model.dart';
import 'package:passenger/features/tracking_page/presentation/bloc/tracking_page_bloc.dart';
import 'package:passenger/main.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/date_util.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';
import 'package:passenger/util/util.dart';
import 'package:passenger/util/widgets/custom_button.dart';

class BookingAdvanceSuccessWidget extends StatefulWidget {
  const BookingAdvanceSuccessWidget({
    Key? key,
    required this.driverAcceptBookingModel,
    required this.bookingOrderModel,
    this.onValueChanged,
    required this.time,
    required this.paymentMethod,
  }) : super(key: key);
  final DriverAcceptBookingModel driverAcceptBookingModel;
  final BookingOrderModel bookingOrderModel;
  final Function(int step)? onValueChanged;
  final String time;
  final PaymentMethodData? paymentMethod;

  @override
  State<BookingAdvanceSuccessWidget> createState() =>
      _BookingAdvanceSuccessWidgetState();
}

class _BookingAdvanceSuccessWidgetState
    extends State<BookingAdvanceSuccessWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Column(
        children: <Widget>[
          SvgPicture.asset(SvgAssets.icDone),
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

  void clearAllData() {
    BlocProvider.of<LandingPageBloc>(context).add(ClearDataLandingEvent());
    BlocProvider.of<LandingPageBloc>(context).add(InitializeLandingEvent());
    BlocProvider.of<BookingPageBloc>(context).add(ClearStateEvent());
    BlocProvider.of<TrackingPageBloc>(context).add(ClearDataEvent());
  }

  _buildPaymentWidget(
    BuildContext context,
    DriverAcceptBookingModel driverAcceptBookingModel,
  ) {
    return <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            S(context).total,
            style: StylesConstant.ts16w400,
          ),
          Text(
            driverAcceptBookingModel.data!.totalAmount.toString(),
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
              CachedNetworkImage(
                height: 12.w,
                imageUrl: widget.paymentMethod?.paymentIcon.toString() ?? '',
                errorWidget: (_, String url, __) =>
                    SvgPicture.asset(SvgAssets.icPaymentVisa),
              )
            ],
          ),
          Text(
            '${S(context).my_card} ***${widget.paymentMethod?.cardLastDigits}',
            style: StylesConstant.ts16w500,
          )
        ],
      )
    ];
  }

  Widget _buildDivider() {
    return const Divider();
  }

  Widget _buildRemainingTimeWidget(BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    return Column(
      children: <Widget>[
        Text(
          S(context).success_advance_booking,
          style:
              StylesConstant.ts16w500.copyWith(color: ColorsConstant.cFFA33AA3),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              SvgAssets.icClock,
              color: ColorsConstant.cFFA33AA3,
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              DateUtil.formatDateTimeForBooking(
                locale,
                DateTime.parse(widget.time.toString()),
              ),
              style: StylesConstant.ts20w400
                  .copyWith(color: ColorsConstant.cFFA33AA3),
            ),
          ],
        ),
        SizedBox(
          height: 42.h,
        ),
      ],
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
          BookingStatus.confirmed
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
                              imageUrl: driverInfoAccepted.avatar ?? '',
                            ),
                          ),
                        ),
                        Positioned(
                          left: 26.w,
                          child: CachedNetworkImage(
                            imageUrl: carInfo.icon ?? '',
                            width: 69.w,
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
                              urlSchemaUtil('027777564', UrlSchemaType.phone),
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
                                driverId:
                                    driverInfoAccepted.driverId ?? demoDriverId,
                                driverName:
                                    driverInfoAccepted.name ?? demoDriverName,
                              ),
                            );
                          },
                          child: SvgPicture.asset(
                            SvgAssets.icMessage,
                            height: 20.w,
                          ),
                        ),
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
            SizedBox(
              height: 110.h,
            ),
            CustomButton(
              params: CustomButtonParams.primary(
                onPressed: () {
                  clearAllData();
                  Navigator.popUntil(
                    context,
                    (Route<dynamic> route) =>
                        route.settings.name == MyHomePage.routeName,
                  );
                },
                text: S(context).agree,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
