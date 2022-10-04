import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/data/model/payment_method_model.dart';
import 'package:passenger/features/payment/presentation/bloc_payment_method/payment_method_bloc.dart';
import 'package:passenger/features/payment/presentation/list_payment_method_page.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';

import '../../../../util/enum.dart';

class PaymentMethodContent extends StatelessWidget {
  const PaymentMethodContent({Key? key}) : super(key: key);

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
    return BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
      builder: (BuildContext context, PaymentMethodState state) {
        PaymentMethodData? currentPayment = state.currentPayment;
        return Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: 24.w,
                right: 24.w,
                top: 24.h,
                bottom: 8.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    S(context).payment_methods,
                    style: StylesConstant.ts16w500.copyWith(
                      color: ColorsConstant.cFF454754,
                    ),
                  ),
                  if (state.infoPaymentState == LoadState.success)
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        ListPaymentMethodPage.routeName,
                      ).then((Object? value) {}),
                      child: Text(
                        S(context).select_payment_method,
                        style: StylesConstant.ts14w500.copyWith(
                          color: ColorsConstant.cFFA33AA3,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: ColorsConstant.cWhite,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 16.h,
                ),
                child: Row(
                  children: <Widget>[
                    if (state.infoPaymentState == LoadState.loading)
                      const CupertinoActivityIndicator(),
                    ..._buildCurrentPaymentMethod(currentPayment)
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  String getLastCardNumber(PaymentMethodData data) {
    if (data.cardLastDigits == null) {
      return '';
    }
    return '***${data.cardLastDigits}';
  }

  _buildCurrentPaymentMethod(PaymentMethodData? currentPayment) {
    if (currentPayment == null) {
      return <Widget>[const SizedBox()];
    }
    String paymentName = getPaymentName(currentPayment);
    return <Widget>[
      Image.network(
        currentPayment.paymentType?.icon ?? '',
        loadingBuilder: (
          _,
          Widget child,
          ImageChunkEvent? loadingProgress,
        ) {
          if (loadingProgress == null) return child;
          return const CupertinoActivityIndicator();
        },
        fit: BoxFit.contain,
        width: 24.w,
        height: 24.w,
      ),
      SizedBox(
        width: 8.w,
      ),
      Expanded(
        child: Text(
          paymentName,
          style: StylesConstant.ts16w400.copyWith(
            color: ColorsConstant.cFF454754,
          ),
        ),
      ),
      Text(
        getLastCardNumber(currentPayment),
        style: StylesConstant.ts16w500.copyWith(
          color: ColorsConstant.cFF454754,
        ),
      ),
    ];
  }
}
