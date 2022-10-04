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
import 'package:passenger/main.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';
import 'package:passenger/util/widgets/custom_button.dart';

class NotFoundAlert extends StatelessWidget {
  const NotFoundAlert({
    Key? key,
    required this.price,
    required this.listLocationRequest,
    required this.bookingOrderModel,
    required this.onPressed,
  }) : super(key: key);

  final double price;
  final List<LocationRequest>? listLocationRequest;
  final BookingOrderModel? bookingOrderModel;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 16.h,
        ),
        SvgPicture.asset(SvgAssets.icFindCar),
        SizedBox(
          height: 8.h,
        ),
        Text(
          S(context).cannot_find_driver,
          style: StylesConstant.ts16w500cWhite
              .copyWith(color: ColorsConstant.cFFA33AA3),
        ),
        SizedBox(
          height: 24.h,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            gradient: ColorsConstant.appPrimaryGradient,
          ),
          child: CustomButton(
            params: CustomButtonParams.primary(
              text: S(context).search_again,
              wrapWidth: true,
              onPressed: onPressed,
            ),
          ),
        ),
        InformationAddressWidget(
          key: const ValueKey<String>('tracking-page-address-info'),
          price: price,
          listLocationRequest: listLocationRequest,
        ),
        BlocConsumer<TrackingPageBloc, TrackingPageState>(
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
            return InkWell(
              onTap: () {
                BlocProvider.of<TrackingPageBloc>(context).add(
                  CancelBookingNotDriverEvent(
                    CancelBookingBody(
                      id: bookingOrderModel?.data?.id ?? '',
                      cancelReason: '',
                      userId: bookingOrderModel?.data?.userId ?? '',
                    ),
                  ),
                );
              },
              child: Text(S(context).cancel_reservation),
            );
          },
        )
      ],
    );
  }
}
