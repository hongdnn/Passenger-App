import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/data/model/price_by_cartype_model.dart';
import 'package:passenger/features/booking_page/data/model/upsert_draft_booking_model.dart';
import 'package:passenger/features/booking_page/presentation/bloc/booking_page_bloc.dart';
import 'package:passenger/util/distance_util.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/time_util.dart';
import 'package:passenger/util/widgets/custom_button.dart';

class NextButtonOnBookingPage extends StatefulWidget {
  const NextButtonOnBookingPage({
    Key? key,
    required this.selectedCarType,
    required this.enableBtnListen,
    required this.isBookingNow,
    required this.selectedDateTime,
    required this.listLocaleRequest,
    required this.valueSilentRide,
    this.distanceBetweenTwoPoint = 0,
    this.timeEst = 0,
  }) : super(key: key);

  final ValueNotifier<CarInfoByPrice?> selectedCarType;
  final ValueNotifier<bool> enableBtnListen;
  final ValueNotifier<bool> isBookingNow;
  final ValueNotifier<DateTime?> selectedDateTime;
  final List<LocationRequest> listLocaleRequest;
  final ValueNotifier<bool> valueSilentRide;
  final double distanceBetweenTwoPoint;
  final double timeEst;

  @override
  State<NextButtonOnBookingPage> createState() =>
      _NextButtonOnBookingPageState();
}

class _NextButtonOnBookingPageState extends State<NextButtonOnBookingPage> {
  final EdgeInsets kDefaultPadding = EdgeInsets.symmetric(
    vertical: 4.w,
    horizontal: 8.w,
  );

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        height: 76.h,
        color: Colors.white,
        child: ValueListenableBuilder<CarInfoByPrice?>(
          valueListenable: widget.selectedCarType,
          builder: (_, CarInfoByPrice? value, Widget? error) {
            return ValueListenableBuilder<bool>(
              valueListenable: widget.enableBtnListen,
              builder: (_, bool value, Widget? error) {
                return ValueListenableBuilder<bool>(
                  valueListenable: widget.isBookingNow,
                  builder: (_, bool value, Widget? error) {
                    return ValueListenableBuilder<DateTime?>(
                      valueListenable: widget.selectedDateTime,
                      builder: (_, DateTime? time, Widget? child) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 16.h,
                          ),
                          child: BlocBuilder<BookingPageBloc, BookingPageState>(
                            builder:
                                (BuildContext context, BookingPageState state) {
                              return CustomButton(
                                params: widget.isBookingNow.value
                                    ? _customButtonParams(
                                        isClickable:
                                            widget.selectedCarType.value !=
                                                    null &&
                                                widget.enableBtnListen.value,
                                        carType: widget.selectedCarType.value
                                                ?.driverTypeId ??
                                            -1,
                                      )
                                    : _customButtonParams(
                                        isClickable:
                                            widget.selectedDateTime.value !=
                                                    null &&
                                                widget.selectedCarType.value !=
                                                    null &&
                                                widget.enableBtnListen.value,
                                        carType: widget.selectedCarType.value
                                                ?.driverTypeId ??
                                            -1,
                                      ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  CustomButtonParams _customButtonParams({
    required bool isClickable,
    required int carType,
  }) {
    if (isClickable) {
      return CustomButtonParams.primary(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const CupertinoActivityIndicator(
              color: Colors.white,
            ),
          );
          BlocProvider.of<BookingPageBloc>(context).add(
            UpsertDraftBookingEvent(
              body: UpsertRequestBody(
                deviceId: BlocProvider.of<BookingPageBloc>(
                  context,
                ).getCurrentUser().id,
                carType: carType,
                locations: widget.listLocaleRequest,
                isSilent: widget.valueSilentRide.value,
                noteForDriver: '',
                isTripLater: !widget.isBookingNow.value,
                startTime: widget.isBookingNow.value
                    ? null
                    : widget.selectedDateTime.value?.toIso8601String(),
                distance: DistanceUtil.convertMeterToKm(
                  widget.distanceBetweenTwoPoint,
                ),
                totalTime:
                    TimeUtil.convertSecondToMinute(widget.timeEst.toInt())
                        .toDouble(),
                price: widget.selectedCarType.value?.price,
              ),
              selectedRoute: defaultSelectedRoute,
            ),
          );
        },
        text: S(context).next,
      ).copyWith(
        padding: kDefaultPadding,
      );
    } else {
      return CustomButtonParams.primaryUnselected(
        text: S(context).next,
      );
    }
  }
}
