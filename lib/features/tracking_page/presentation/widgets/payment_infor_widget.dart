import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/data/model/payment_method_model.dart';
import 'package:passenger/features/tracking_page/presentation/bloc/tracking_page_bloc.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';

class PaymentInforWidget extends StatelessWidget {
  const PaymentInforWidget({
    Key? key,
    required this.price,
  }) : super(key: key);
  final double? price;

  String getPaymentName(PaymentMethodData currentPayment) {
    if (currentPayment.paymentType?.isCard != null &&
        currentPayment.paymentType?.isCard == true) {
      return currentPayment.name ?? '';
    } else {
      return currentPayment.paymentType?.name ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackingPageBloc, TrackingPageState>(
      builder: (_, TrackingPageState state) {
        PaymentMethodData? currentPayment =
            state.driverAcceptBookingModel?.data?.paymentMethod;
        String currentPrice =
            (state.driverAcceptBookingModel?.data?.price ?? 0).toString();
        String? paymentIcon = currentPayment?.paymentType?.icon;
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: (paymentIcon?.isNotEmpty == true)
                          ? CachedNetworkImage(
                              width: 24.w,
                              height: 24.h,
                              fit: BoxFit.contain,
                              imageUrl: paymentIcon!,
                              errorWidget:
                                  (BuildContext context, String url, _) =>
                                      SvgPicture.asset(
                                SvgAssets.icRbhCar,
                              ),
                              placeholder: (BuildContext context, String url) =>
                                  const CupertinoActivityIndicator(),
                            )
                          : SvgPicture.asset(
                              SvgAssets.icPaymentSCB,
                              width: 24.w,
                              height: 24.h,
                            ),
                    ),
                    SizedBox(
                      width: 8.h,
                    ),
                    Text(
                      S(context).my_card,
                      style: StylesConstant.ts14w400.copyWith(
                        color: ColorsConstant.cFF73768C,
                      ),
                    ),
                  ],
                ),
              ),
              const VerticalDivider(),
              Flexible(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    currentPrice,
                    style: StylesConstant.ts14w400.copyWith(
                      color: ColorsConstant.cFF73768C,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
