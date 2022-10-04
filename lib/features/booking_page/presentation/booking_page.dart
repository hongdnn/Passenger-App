import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/features/booking_page/data/model/price_by_cartype_model.dart';
import 'package:passenger/features/booking_page/data/model/upsert_draft_booking_model.dart';
import 'package:passenger/features/booking_page/presentation/bloc/booking_page_bloc.dart';
import 'package:passenger/features/booking_page/presentation/extension/booking_ext.dart';
import 'package:passenger/features/booking_page/presentation/widget/booking_page_content.dart';
import 'package:passenger/features/booking_page/presentation/widget/map_route_booking.dart';
import 'package:passenger/features/booking_page/presentation/widget/next_button.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
import 'package:passenger/features/location/data/model/location_address_model.dart';
import 'package:passenger/features/location/data/repo/current_location_repo.dart';
import 'package:passenger/util/android_google_maps_back_mixin.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/styles.dart';
import 'package:passenger/util/widgets/screen_collapse_appbar.dart';
import 'package:passenger/util/widgets/time_picker_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingLocationList {
  BookingLocationList({
    this.currentLocation,
    this.firstLocation,
    this.secondLocation,
    this.thirdLocation,
    this.location,
  });

  LocationAddressModel? currentLocation;
  LocationAddressModel? firstLocation;
  LocationAddressModel? secondLocation;
  LocationAddressModel? thirdLocation;
  LocationAddressModel? location;
}

class BookingArg {
  BookingArg({
    required this.bookingLocationList,
    this.reorderBookingData,
  });

  BookingLocationList? bookingLocationList;
  BookingData? reorderBookingData;
}

class BookingPage extends StatefulWidget {
  const BookingPage({
    Key? key,
    required this.arg,
  }) : super(key: key);
  static const String routeName = '/bookingPage';
  final BookingArg arg;

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage>
    with
        SingleTickerProviderStateMixin,
        AndroidGoogleMapsBackMixin<BookingPage> {
  // Initial selected == first car
  ValueNotifier<CarInfoByPrice?> selectedCarType =
      ValueNotifier<CarInfoByPrice?>(null);

  ValueNotifier<int> currentCategory =
      ValueNotifier<int>(CarCategory.emptyCategory.value);

  //value silent ride
  ValueNotifier<bool> valueSilentRide = ValueNotifier<bool>(false);

  late AnimationController _expandController;
  late Animation<double> _bookingAdvanceAnimation;
  final ValueNotifier<DateTime?> _selectedDateTime =
      ValueNotifier<DateTime?>(null);
  List<LocationRequest> listLocaleRequest = <LocationRequest>[];
  final ValueNotifier<double> _distanceEst = ValueNotifier<double>(0);
  final ValueNotifier<double> _timeEst = ValueNotifier<double>(0);
  final ValueNotifier<bool> enableBtnListen = ValueNotifier<bool>(false);
  ValueNotifier<bool> isBookingNow = ValueNotifier<bool>(
    getIt<SharedPreferences>().getBool('isBookingNow') ?? true,
  );

  void _prepareAnimations() {
    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _bookingAdvanceAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck(bool expand) {
    if (expand) {
      _expandController.forward();
    } else {
      _expandController.reverse();
    }
  }

  @override
  void initState() {
    super.initState();

    _prepareAnimations();
    _runExpandCheck(!isBookingNow.value);

    if (widget.arg.bookingLocationList != null) {
      _initBookingArgs();
    } else {
      _initRerideBookingArgs();
    }
    initBlocEvent();
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  void _initBookingArgs() {
    addToLocationRequest(
      data: widget.arg.bookingLocationList?.currentLocation,
      isFirstLocation: true,
    );
    addToLocationRequest(data: widget.arg.bookingLocationList?.firstLocation);
    addToLocationRequest(data: widget.arg.bookingLocationList?.secondLocation);
    addToLocationRequest(data: widget.arg.bookingLocationList?.thirdLocation);
  }

  void _initRerideBookingArgs() {
    List<TripLocation> listBookingLocation =
        widget.arg.reorderBookingData!.trip!.locations!;
    listLocaleRequest = List<LocationRequest>.generate(
      listBookingLocation.length,
      (int index) =>
          LocationRequest.fromTripLocation(listBookingLocation[index])
            ..copyWith(pathToLocationParams: ''),
    );
  }

  void addToLocationRequest({
    LocationAddressModel? data,
    bool isFirstLocation = false,
  }) {
    if (data != null) {
      listLocaleRequest.add(
        LocationRequest.fromLocationAddressModel(
          data,
        ),
      );
      return;
    }
    if (isFirstLocation == true) {
      listLocaleRequest.add(
        LocationRequest.fromPlaceDetail(
          getIt<CurrentLocationRepo>().placeDetailModel!,
        ),
      );
      return;
    }
  }

  void initBlocEvent() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<BookingPageBloc>(context)
        ..add(InitEvent(listLocaleRequest: listLocaleRequest))
        ..add(
          GetDirectionFromOriginToDestination(
            listLocaleRequest: listLocaleRequest,
          ),
        )
        ..add(
          LoadingCarPriceListEvent(
            getPriceRequestBody: GetPriceRequestBody(
              depLat: listLocaleRequest.first.latitude,
              depLng: listLocaleRequest.first.longitude,
              desLat: listLocaleRequest.last.latitude,
              desLng: listLocaleRequest.last.longitude,
              distance: radiusDriverMeter.toInt(),
            ),
          ),
        );
    });
  }

  void _onTapCarItem({
    int? currentTypeId,
    int? driverIndex,
    BookingPageState? bookingPageState,
  }) {
    if (bookingPageState?.carPriceList?[driverIndex ?? 0].cars?.isNotEmpty ==
        true) {
      final int index =
          bookingPageState!.carPriceList![driverIndex ?? 0].cars!.indexWhere(
        (CarInfoByPrice element) => element.driverTypeId == currentTypeId,
      );
      final CarInfoByPrice? carPrice =
          bookingPageState.carPriceList?[driverIndex ?? 0].cars?[index];
      if (selectedCarType.value?.driverTypeId == currentTypeId) {
        selectedCarType.value = null;
      } else {
        selectedCarType.value = carPrice!;
        currentCategory.value = driverIndex ?? CarCategory.emptyCategory.value;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          BlocListener<BookingPageBloc, BookingPageState>(
            listenWhen: (BookingPageState previous, BookingPageState current) {
              return previous.mapStatus != current.mapStatus ||
                  previous.listRouteOptions != current.listRouteOptions ||
                  previous.listLocaleRequest != current.listLocaleRequest ||
                  shouldListenDiffPrice(previous, current);
            },
            listener: (BuildContext context, BookingPageState state) {
              if (state.mapStatus == LoadState.success) {
                _distanceEst.value = state
                        .listRouteOptions[defaultSelectedRoute].totalDistance ??
                    0;
                _timeEst.value = state
                        .listRouteOptions[defaultSelectedRoute].totalDuration ??
                    0;

                log('carListPriceStatus: ${state.getListCarPriceStatus}');
                if (state.getListCarPriceStatus == LoadState.success &&
                    state.carPriceList?.isNotEmpty == true) {
                  currentCategory.value = 0;
                  if (state.carPriceList?[currentCategory.value].cars
                          ?.isNotEmpty ==
                      true) {
                    final CarInfoByPrice? carPrice =
                        state.carPriceList?[currentCategory.value].cars?.first;
                    selectedCarType.value = carPrice;

                    _distanceEst.value = state
                            .listRouteOptions[defaultSelectedRoute]
                            .totalDistance ??
                        0;
                    _timeEst.value = state
                            .listRouteOptions[defaultSelectedRoute]
                            .totalDuration ??
                        0;
                    enableBtnListen.value = true;
                  }
                } else {
                  currentCategory.value = CarCategory.emptyCategory.value;
                }
              } else {
                enableBtnListen.value = false;
              }
            },
            child: ScreenCollapseAppbar(
              hasTrailingIcon: false,
              flexibleBackground:
                  BlocBuilder<BookingPageBloc, BookingPageState>(
                buildWhen:
                    (BookingPageState previous, BookingPageState current) {
                  return previous.mapStatus != current.mapStatus ||
                      current.listRouteOptions != previous.listRouteOptions;
                },
                builder: (BuildContext context, BookingPageState state) {
                  if (state.mapStatus == LoadState.loading ||
                      state.mapStatus == LoadState.none) {
                    return const Center(child: CupertinoActivityIndicator());
                  }
                  return MapRouteBooking(
                    args: MapRouteBookingArgs(
                      locations: listLocaleRequest,
                      listRouteOptions: state.listRouteOptions,
                      onChangeSelectedRoute: (int idx) {
                        if (idx != defaultSelectedRoute) {
                          BlocProvider.of<BookingPageBloc>(context)
                              .add(ReorderListRouteEvent(swapIndex: idx));
                        }
                      },
                    ),
                  );
                },
              ),
              isShowTitleFlexible: true,
              title: Text(
                S(context).get_a_car,
                style: StylesConstant.ts20w500.copyWith(
                  color: ColorsConstant.cFF454754,
                ),
                textAlign: TextAlign.center,
              ),
              isTapOnIconBack: false,
              onTapIconBack: () {
                popBack(context);
              },
              content: AnimatedBuilder(
                animation: Listenable.merge(<ValueNotifier<dynamic>>[
                  _selectedDateTime,
                  selectedCarType,
                  isBookingNow,
                  valueSilentRide,
                  currentCategory,
                  _distanceEst,
                  _timeEst,
                ]),
                builder: (_, Widget? child) {
                  return BookingPageContent(
                    runExpandCheck: _runExpandCheck,
                    distanceEst: _distanceEst.value,
                    timeEst: _timeEst.value,
                    selectedDateTime: _selectedDateTime,
                    selectedCarType: selectedCarType,
                    listLocaleRequest: listLocaleRequest,
                    isBookingNow: isBookingNow,
                    onTapCarItem: _onTapCarItem,
                    valueSilentRide: valueSilentRide,
                    currentCategory: currentCategory,
                    bookingAdvanceAnimation: _bookingAdvanceAnimation,
                  );
                },
              ),
            ),
          ),
          AnimatedBuilder(
            animation: Listenable.merge(<ValueNotifier<dynamic>>[
              valueSilentRide,
              isBookingNow,
              enableBtnListen,
              _selectedDateTime,
              selectedCarType,
              _distanceEst,
              _timeEst,
            ]),
            builder: (_, Widget? child) {
              return NextButtonOnBookingPage(
                valueSilentRide: valueSilentRide,
                isBookingNow: isBookingNow,
                enableBtnListen: enableBtnListen,
                listLocaleRequest: listLocaleRequest,
                selectedDateTime: _selectedDateTime,
                selectedCarType: selectedCarType,
                distanceBetweenTwoPoint: _distanceEst.value,
                timeEst: _timeEst.value,
              );
            },
          ),
        ],
      ),
    );
  }
}
