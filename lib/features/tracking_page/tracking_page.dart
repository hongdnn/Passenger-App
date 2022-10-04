import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/data/model/booking_order_model.dart';
import 'package:passenger/features/booking_page/data/model/upsert_draft_booking_model.dart';
import 'package:passenger/features/booking_page/presentation/bloc/booking_page_bloc.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
import 'package:passenger/features/location/data/model/direction_model.dart';
import 'package:passenger/features/location/data/model/place_detail_model.dart';
import 'package:passenger/features/location/data/repo/current_location_repo.dart';
import 'package:passenger/features/location/data/repo/direction_result_model.dart';
import 'package:passenger/features/payment/presentation/payment_page.dart';
import 'package:passenger/features/tracking_page/data/model/driver_accept_booking_model.dart';
import 'package:passenger/features/tracking_page/presentation/bloc/tracking_page_bloc.dart';
import 'package:passenger/features/tracking_page/presentation/widgets/booking_advance_success_widget.dart';
import 'package:passenger/features/tracking_page/presentation/widgets/map_current_location_to_destination.dart';
import 'package:passenger/features/tracking_page/presentation/widgets/map_driver_to_user.dart';
import 'package:passenger/features/tracking_page/presentation/widgets/map_tracking_driver.dart';
import 'package:passenger/features/tracking_page/presentation/widgets/search_car.dart';
import 'package:passenger/features/tracking_page/presentation/widgets/tracking_progress_widget.dart';
import 'package:passenger/util/enum.dart';

import 'package:passenger/util/size.dart';
import 'package:passenger/util/widgets/custom_dialog.dart';
import 'package:passenger/util/widgets/screen_collapse_appbar.dart';

import 'package:passenger/main.dart';

class TrackingArgs {
  TrackingArgs({
    this.listLocationRequest,
    this.distance,
    this.timeEst,
    this.bookingOrderModel,
    this.driverAcceptBookingModel,
    this.isBookingNow,
    this.price,
    required this.isLandingPageNavTo,
    required this.isDriverFound,
    this.bookingId,
    this.advancedBookingTime,
  });

  final List<LocationRequest>? listLocationRequest;
  final double? distance;
  final double? timeEst;
  final double? price;
  final BookingOrderModel? bookingOrderModel;
  final DriverAcceptBookingModel? driverAcceptBookingModel;
  final bool? isBookingNow;
  final bool? isDriverFound;
  final bool? isLandingPageNavTo;
  final String? bookingId;
  final DateTime? advancedBookingTime;
}

class TrackingPage extends StatefulWidget {
  const TrackingPage({Key? key, required this.trackingArgs}) : super(key: key);
  static const String routeName = '/trackingPage';
  final TrackingArgs? trackingArgs;

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  final PlaceDetailModel? currentLocation =
      getIt<CurrentLocationRepo>().placeDetailModel;

  late String bookingId;
  late List<LocationRequest> listLocationRequest;
  late List<LocationRequest> listLocationFromDriverToUser;
  List<LocationRequest> driverAndUser = <LocationRequest>[];
  final ValueNotifier<int> stepTrackingListener = ValueNotifier<int>(0);
  final ValueNotifier<bool> statusBooking = ValueNotifier<bool>(false);
  late String idDriverBooking;

  @override
  void initState() {
    super.initState();
    log('idBooking:${widget.trackingArgs?.bookingId}');
    listLocationRequest =
        widget.trackingArgs?.listLocationRequest ?? <LocationRequest>[];
    listLocationFromDriverToUser = <LocationRequest>[
      LocationRequest(
        latitude: (getIt<CurrentLocationRepo>().placeDetailModel?.getLatitude ??
                21.005970829462743) +
            0.0005,
        longitude:
            (getIt<CurrentLocationRepo>().placeDetailModel?.getLongitude ??
                    105.81696776877018) +
                0.0005,
      ),
      widget.trackingArgs!.listLocationRequest!.first,
    ];
    BlocProvider.of<TrackingPageBloc>(context)
        // .
        .add(
      GetBookingInfoByIdEvent(
        widget.trackingArgs?.bookingId ?? '',
      ),
    );
    if (widget.trackingArgs?.isLandingPageNavTo == false) {
      BlocProvider.of<TrackingPageBloc>(context).add(
        SearchDriverForBookingEvent(
          widget.trackingArgs?.bookingId ?? '',
        ),
      );
    }
  }

  @override
  void dispose() {
    listLocationRequest.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<TrackingPageBloc, TrackingPageState>(
        listener: (BuildContext context, TrackingPageState state) {
          if (state.errorMessage?.isEmpty == false) {
            showCustomDialog(
              context: context,
              options: CustomDialogParams(
                title: S(context).notification,
                message: state.errorMessage,
              ),
            );
          }
        },
        child: BlocConsumer<TrackingPageBloc, TrackingPageState>(
          bloc: BlocProvider.of<TrackingPageBloc>(context),
          listenWhen: (TrackingPageState previous, TrackingPageState current) =>
              previous.finishTripState != current.finishTripState,
          listener: (BuildContext context, TrackingPageState state) {
            if (state.acceptBookingState == LoadState.success) {
              listLocationRequest.clear();
              for (TripLocation location
                  in state.driverAcceptBookingModel!.data!.trip!.locations!) {
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

              List<LocationRequest> listDriverAndUser = <LocationRequest>[];

              listDriverAndUser.add(
                LocationRequest(
                  addressName:
                      state.driverAcceptBookingModel?.data?.driverInfo?.name,
                  latitude: state.driverAcceptBookingModel?.data?.driverInfo
                          ?.latitude ??
                      0,
                  longitude: state.driverAcceptBookingModel?.data?.driverInfo
                          ?.longitude ??
                      0,
                ),
              );
              listDriverAndUser.add(listLocationRequest.first);
              driverAndUser = listDriverAndUser;

              BlocProvider.of<BookingPageBloc>(context)
                ..add(InitEvent(listLocaleRequest: driverAndUser))
                ..add(
                  GetDirectionFromOriginToDestination(
                    listLocaleRequest: driverAndUser,
                    alternatives: false,
                  ),
                );
            }
          },
          builder: (_, TrackingPageState state) {
            return ScreenCollapseAppbar(
              isLeadingIconBackgroundColor: false,
              hasTrailingIcon: false,
              canScroll: true,
              height: 327.h,
              isTapOnIconBack: true,
              onTapIconBack: () {
                Navigator.of(context).popUntil(
                  // ignore: always_specify_types
                  (route) => route.settings.name == MyHomePage.routeName,
                );
              },
              flexibleBackground: widget.trackingArgs?.isBookingNow != null &&
                      widget.trackingArgs!.isBookingNow!
                  ? state.acceptBookingState != LoadState.success
                      ? _trackingDriver()
                      : _successTrackingDriver()
                  : const MapTrackingDriverWidget(),
              isSliverAppBarScrolled: true,
              content: _trackingContent(
                condition: state.acceptBookingState != LoadState.success,
                driverAcceptBookingModel: state.driverAcceptBookingModel ??
                    widget.trackingArgs?.driverAcceptBookingModel ??
                    DriverAcceptBookingModel(),
                bookingStatus: state.bookingStatus ?? BookingStatus.waiting,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _trackingContent({
    required bool condition,
    required DriverAcceptBookingModel driverAcceptBookingModel,
    required BookingStatus bookingStatus,
  }) {
    return BlocConsumer<TrackingPageBloc, TrackingPageState>(
      listenWhen: (TrackingPageState previous, TrackingPageState current) =>
          previous.bookingStatus != current.bookingStatus,
      listener: (BuildContext context, TrackingPageState state) {
        log('state:${state.bookingStatus}');
        log('errorMessage:${state.errorMessage}');
        if (state.bookingStatus == BookingStatus.completed) {
          Navigator.pushNamed(
            context,
            PaymentPage.routeName,
            arguments: PaymentArg(
              listLocation: listLocationRequest,
              bookingId: widget.trackingArgs?.bookingOrderModel?.data?.id ?? '',
            ),
          );
        }
        // if (state.bookingStatus == BookingStatus.searching) {
        //   BlocProvider.of<TrackingPageBloc>(context).add(
        //     SearchDriverForBookingEvent(
        //       widget.trackingArgs?.bookingOrderModel?.data?.id ?? '',
        //     ),
        //   );
        // }
      },
      builder: (BuildContext context, TrackingPageState state) {
        if (<BookingStatus>[
          BookingStatus.driverFound,
          BookingStatus.driverAlmostArrive,
          BookingStatus.driverArrive,
          BookingStatus.driverPickUp,
          BookingStatus.processing,
          BookingStatus.dropOffMidDestination,
        ].any((BookingStatus element) => element == state.bookingStatus)) {
          return _bookingSuccess(driverAcceptBookingModel);
        } else {
          return SearchingCar(
            listLocationRequest: widget.trackingArgs?.listLocationRequest,
            bookingOrderModel:
                widget.trackingArgs?.bookingOrderModel ?? BookingOrderModel(),
            price: widget.trackingArgs?.price ?? 0,
            advancedBookingTime: widget.trackingArgs?.advancedBookingTime,
            key: const ValueKey<String>(
              'tracking-page-not-found',
            ),
          );
        }
      },
    );
  }

  Widget _bookingSuccess(DriverAcceptBookingModel driverAcceptBookingModel) {
    return BlocBuilder<BookingPageBloc, BookingPageState>(
      builder: (_, BookingPageState bookingState) {
        return BlocBuilder<TrackingPageBloc, TrackingPageState>(
          builder: (_, TrackingPageState state) {
            if (widget.trackingArgs?.isBookingNow != null &&
                widget.trackingArgs!.isBookingNow!) {
              return TrackingProgressWidget(
                key: const ValueKey<String>(
                  'TrackingProgressWidget',
                ),
                driverAcceptBookingModel: driverAcceptBookingModel,
                bookingOrderModel: widget.trackingArgs?.bookingOrderModel ??
                    BookingOrderModel(),
              );
            } else {
              return BookingAdvanceSuccessWidget(
                driverAcceptBookingModel: driverAcceptBookingModel,
                paymentMethod:
                    bookingState.bookingOrderModel?.data?.paymentMethod,
                bookingOrderModel: widget.trackingArgs?.bookingOrderModel ??
                    BookingOrderModel(),
                time: state.driverAcceptBookingModel?.data?.trip?.startTime
                        .toString() ??
                    '',
              );
            }
          },
        );
      },
    );
  }

  Widget _trackingDriver() {
    return const MapTrackingDriverWidget();
  }

  Widget _successTrackingDriver() {
    return ValueListenableBuilder<int>(
      valueListenable: stepTrackingListener,
      builder: (
        BuildContext _,
        int? currentStep,
        Widget? __,
      ) {
        return currentStep == 0
            ? _mapDriverToCurrentLocation()
            : _mapCurrentLocationToDestination();
      },
    );
  }

  Widget _mapCurrentLocationToDestination() {
    return MapCurrentLocationToDestination(
      args: MapCurrentLocationToDestinationArgs(
        listLatLngPolyline: BlocProvider.of<TrackingPageBloc>(context)
            .getLatestPolylineList!
            .map((DirectionResultModel e) => e.polyline!)
            .toSet(),
        locations: listLocationRequest,
        distance: Distance(
          text: 'Distance',
          value: BlocProvider.of<TrackingPageBloc>(context).getDistance ??
              widget.trackingArgs?.distance ??
              0,
        ),
        duration: DurationModel(
          text: 'durationModel',
          value: BlocProvider.of<TrackingPageBloc>(context).getDuration ??
              widget.trackingArgs?.timeEst,
        ),
      ),
    );
  }

  Widget _mapDriverToCurrentLocation() {
    return BlocBuilder<BookingPageBloc, BookingPageState>(
      builder: (BuildContext context, BookingPageState state) {
        if (state.mapStatus == LoadState.loading) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (state.mapStatus == LoadState.success ||
            state.mapStatus == LoadState.failure) {
          return MapDriverToCurrentLocation(
            args: MapRouteDriverToCurrentLocationArgs(
              listLatLngPolyline: (state.listRouteOptions.last.routeOptions ??
                      <DirectionResultModel>[])
                  .map((DirectionResultModel e) => e.polyline!)
                  .toSet(),
              locations: List<LocationRequest>.from(listLocationRequest),
              distance: Distance(
                value: state.listRouteOptions.last.totalDistance ?? 0,
              ),
              duration: DurationModel(
                value: state.listRouteOptions.last.totalDuration ?? 0,
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
