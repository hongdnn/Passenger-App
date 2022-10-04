import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/data/model/booking_order_model.dart';
import 'package:passenger/features/booking_page/data/model/cancel_booking_model.dart';
import 'package:passenger/features/booking_page/data/model/upsert_draft_booking_model.dart';
import 'package:passenger/features/tracking_page/presentation/bloc/tracking_page_bloc.dart';
import 'package:passenger/features/tracking_page/presentation/widgets/information_address_widget.dart';
import 'package:passenger/features/tracking_page/presentation/widgets/not_found_alert.dart';
import 'package:passenger/main.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';

class SearchingCar extends StatefulWidget {
  const SearchingCar({
    Key? key,
    required this.bookingOrderModel,
    required this.price,
    required this.listLocationRequest,
    this.isSearching = false,
    this.advancedBookingTime,
  }) : super(key: key);
  final BookingOrderModel? bookingOrderModel;
  final List<LocationRequest>? listLocationRequest;
  final double? price;
  final bool isSearching;
  final DateTime? advancedBookingTime;

  @override
  State<SearchingCar> createState() => _SearchingCarState();
}

class _SearchingCarState extends State<SearchingCar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<LocationRequest> mockListLocationTest =
      widget.listLocationRequest ?? <LocationRequest>[];

  bool _isSearching = true;

  @override
  void initState() {
    _isSearching = widget.isSearching;
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      upperBound: 0.5,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrackingPageBloc, TrackingPageState>(
      listener: (BuildContext context, TrackingPageState state) {
        log('cancelBookingNotDriver:${state.cancelBookingNotDriver}');

        if (state.cancelBookingNotDriver == LoadState.success) {
          BlocProvider.of<TrackingPageBloc>(context).add(
            ClearDataEvent(),
          );
          Navigator.popUntil(
            context,
            (Route<dynamic> route) =>
                route.settings.name == MyHomePage.routeName,
          );
        }
      },
      builder: (BuildContext context, TrackingPageState state) {
        if (state.bookingStatus == BookingStatus.searching && _isSearching) {
          return NotFoundAlert(
            onPressed: () {
              BlocProvider.of<TrackingPageBloc>(context)
                ..add(ReSearchBookingEvent())
                ..add(
                  SearchDriverForBookingEvent(
                    widget.bookingOrderModel?.data?.id ?? '',
                  ),
                );
              setState(() {
                _isSearching = false;
              });
            },
            price: widget.price ?? 0,
            listLocationRequest: widget.listLocationRequest,
            bookingOrderModel: widget.bookingOrderModel,
          );
        } else {
          return Column(
            children: <Widget>[
              SizedBox(
                height: 16.h,
              ),
              RotationTransition(
                turns: Tween<double>(begin: 0.0, end: 1.0).animate(_controller),
                child: SvgPicture.asset(SvgAssets.icTimeClock),
              ),
              SizedBox(
                height: 16.h,
              ),
              GestureDetector(
                onTap: () {
                  log('test');
                  setState(() {
                    _isSearching = true;
                  });
                },
                child: Text(
                  S(context).looking_for_driver,
                  style: StylesConstant.ts16w500cWhite
                      .copyWith(color: ColorsConstant.cFFA33AA3),
                ),
              ),
              InformationAddressWidget(
                key: const ValueKey<String>('tracking-page-address-info'),
                listLocationRequest: widget.listLocationRequest,
                price: widget.price,
                advancedBookingTime: widget.advancedBookingTime,
              ),
              InkWell(
                onTap: () {
                  BlocProvider.of<TrackingPageBloc>(context).add(
                    CancelBookingNotDriverEvent(
                      CancelBookingBody(
                        id: widget.bookingOrderModel?.data?.id ?? '',
                        cancelReason: '',
                        userId: widget.bookingOrderModel?.data?.userId ?? '',
                      ),
                    ),
                  );
                },
                child: Text(S(context).cancel_reservation),
              ),
            ],
          );
        }
      },
    );
  }
}
