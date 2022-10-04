import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/data/model/booking_order_model.dart';
import 'package:passenger/features/booking_page/data/model/upsert_draft_booking_model.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
import 'package:passenger/features/landing_page/presentation/bloc/landing_page_bloc.dart';
import 'package:passenger/features/tracking_page/presentation/bloc/tracking_page_bloc.dart';
import 'package:passenger/features/tracking_page/presentation/widgets/tracking_progress_widget.dart';
import 'package:passenger/features/tracking_page/presentation/widgets/tracking_slider_widget.dart';
import 'package:passenger/features/tracking_page/tracking_page.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';

class LandingPageTrackStatus extends StatefulWidget {
  const LandingPageTrackStatus({Key? key}) : super(key: key);

  @override
  State<LandingPageTrackStatus> createState() => _LandingPageTrackStatusState();
}

class _LandingPageTrackStatusState extends State<LandingPageTrackStatus> {
  List<LocationRequest> listLocationRequest = <LocationRequest>[];

  void navToTracking(LandingPageState stateLanding, bool isDriverFound) {
    Navigator.pushNamed(
      context,
      TrackingPage.routeName,
      arguments: TrackingArgs(
        listLocationRequest: listLocationRequest,
        distance:
            stateLanding.driverAcceptBookingModel?.data?.distance?.toDouble() ??
                0,
        isBookingNow: true,
        isDriverFound: isDriverFound,
        bookingOrderModel: BookingOrderModel(
          data: BookingData(
            id: stateLanding.driverAcceptBookingModel?.data?.id,
            userId: stateLanding.driverAcceptBookingModel?.data?.userId,
          ),
        ),
        driverAcceptBookingModel: stateLanding.driverAcceptBookingModel,
        isLandingPageNavTo: true,
        bookingId: stateLanding.driverAcceptBookingModel?.data?.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LandingPageBloc, LandingPageState>(
      listenWhen: (LandingPageState previous, LandingPageState current) =>
          current.driverAcceptBookingStatus !=
          previous.driverAcceptBookingStatus,
      listener: (_, LandingPageState stateLanding) {
        if (stateLanding.driverAcceptBookingStatus == LoadState.success &&
            stateLanding.driverAcceptBookingModel?.data?.trip?.id != null) {
          for (TripLocation location in stateLanding
              .driverAcceptBookingModel!.data!.trip!.locations!) {
            listLocationRequest.add(
              LocationRequest(
                longitude: location.longitude,
                latitude: location.latitude,
                address: location.address,
                googleId: location.googleId,
                referenceId: location.referenceId,
                addressName: location.addressName,
                note: location.note.toString(),
              ),
            );
          }

          navToTracking(
            stateLanding,
            stateLanding.driverAcceptBookingModel?.data?.driverInfo?.id != null,
          );
        }
      },
      builder: (_, LandingPageState stateLanding) {
        return GestureDetector(
          onTap: () {
            if (stateLanding.checkBookingAvailabilityStatus ==
                    LoadState.success &&
                stateLanding.checkBookingAvailabilityModel?.data != null &&
                stateLanding.checkBookingAvailabilityModel?.data?.bookingId !=
                    null &&
                stateLanding.checkBookingAvailabilityModel?.data?.bookingId !=
                    '') {
              BlocProvider.of<LandingPageBloc>(
                context,
              ).add(
                GetBookingByIdEvent(
                  stateLanding.checkBookingAvailabilityModel!.data!.bookingId ??
                      '',
                ),
              );
            }
          },
          child: Container(
            alignment: Alignment.bottomCenter,
            height: 90.h,
            color: Colors.white,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: <Widget>[
                  BlocListener<TrackingPageBloc, TrackingPageState>(
                    listener: (_, TrackingPageState state) {
                      if (state.bookingStatus == BookingStatus.searching) {
                        valueSlider.value = 20;
                      } else if (state.bookingStatus ==
                          BookingStatus.driverFound) {
                        valueSlider.value = 20;
                      } else if (state.bookingStatus ==
                          BookingStatus.driverAlmostArrive) {
                        valueSlider.value = 40;
                      } else if (state.bookingStatus ==
                          BookingStatus.driverArrive) {
                        valueSlider.value = 60;
                      } else if (state.bookingStatus ==
                          BookingStatus.driverPickUp) {
                        valueSlider.value = 80;
                      } else if (state.bookingStatus ==
                          BookingStatus.completed) {
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
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          width: double.maxFinite,
                          alignment: Alignment.centerLeft,
                          child:
                              BlocBuilder<TrackingPageBloc, TrackingPageState>(
                            builder: (
                              BuildContext context,
                              TrackingPageState state,
                            ) {
                              return Text(
                                getStatusBooking(state.bookingStatus, context),
                                style: StylesConstant.ts16w400.copyWith(
                                  color: ColorsConstant.cFFA33AA3,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: double.maxFinite,
                          alignment: Alignment.centerRight,
                          child: const Text('10 mins'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

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
        return S(context).driver_found;
    }
  }
}
