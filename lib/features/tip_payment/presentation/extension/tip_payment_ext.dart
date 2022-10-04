import 'package:flutter/widgets.dart';
import 'package:passenger/features/payment/presentation/bloc_payment_method/payment_method_bloc.dart';
import 'package:passenger/features/tip_payment/presentation/tip_payment_page.dart';
import 'package:passenger/util/enum.dart';

extension TipPaymentExtension on State<TipPaymentPage> {
  bool shouldListen(
    PaymentMethodState previous,
    PaymentMethodState current,
  ) {
    return (current.infoPaymentState == LoadState.success &&
            previous.infoPaymentState != current.infoPaymentState) ||
        (current.setPaymentDefaultState != previous.setPaymentDefaultState &&
            current.setPaymentDefaultState == LoadState.success);
  }

  bool shouldBuild(PaymentMethodState previous, PaymentMethodState current) {
    return previous.infoPaymentState != current.infoPaymentState;
  }
}
