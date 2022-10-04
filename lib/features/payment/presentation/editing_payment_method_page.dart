import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/data/model/payment_method_model.dart';
import 'package:passenger/features/payment/presentation/bloc_payment_method/payment_method_bloc.dart';
import 'package:passenger/features/payment/presentation/widget/payment_card_item_widget.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';

class EditingPaymentMethodPage extends StatefulWidget {
  const EditingPaymentMethodPage({Key? key}) : super(key: key);
  static const String routeName = '/EditingPaymentMethodPage';

  @override
  State<EditingPaymentMethodPage> createState() =>
      _EditingPaymentMethodPageState();
}

class _EditingPaymentMethodPageState extends State<EditingPaymentMethodPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstant.cWhite,
      appBar: AppBar(
        title: Text(S(context).edit_card),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: SvgPicture.asset(SvgAssets.icBackIos),
        ),
      ),
      body: BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
        builder: (BuildContext context, PaymentMethodState state) {
          List<PaymentMethodData> listPaymentCard = <PaymentMethodData>[];
          for (PaymentMethodData element in state.listPaymentItem) {
            if (element.paymentType?.isCard == true) {
              listPaymentCard.add(element);
            }
          }
          return ListView.builder(
            itemCount: listPaymentCard.length,
            itemBuilder: (BuildContext context, int index) {
              return PaymentCardItemWidget(
                paymentItem: listPaymentCard[index],
              );
            },
          );
        },
      ),
    );
  }
}
