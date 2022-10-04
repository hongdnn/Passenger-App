import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/data/model/payment_method_model.dart';
import 'package:passenger/features/payment/presentation/bloc_payment_method/payment_method_bloc.dart';
import 'package:passenger/features/payment/presentation/widget/confirm_delete_payment_widget.dart';
import 'package:passenger/features/user/data/repo/user_repo.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';
import 'package:passenger/util/widgets/custom_button.dart';
import 'package:passenger/util/widgets/show_modal_bottom_sheet.dart';

class PaymentCardItemWidget extends StatefulWidget {
  const PaymentCardItemWidget({
    Key? key,
    required this.paymentItem,
  }) : super(key: key);
  final PaymentMethodData paymentItem;

  @override
  State<PaymentCardItemWidget> createState() => _PaymentCardItemState();
}

class _PaymentCardItemState extends State<PaymentCardItemWidget> {
  bool _showSavingButton = false;
  late FocusNode focusInput;
  late TextEditingController controllerInput = TextEditingController();
  late PaymentMethodBloc bloc;

  String? getNickNameCard() {
    if (widget.paymentItem.nickname == '') {
      return S(context).name_of_card;
    }
    return widget.paymentItem.nickname;
  }

  String getDeleteMessageSuccess() {
    String result = S(context).delete_card_success_1;
    result += ' ${widget.paymentItem.name}';
    result += ' ${S(context).delete_card_success_2}';
    return result;
  }

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of(context);
    focusInput = FocusNode();

    controllerInput.addListener(() {
      final String text = controllerInput.text.toLowerCase();
      controllerInput.value = controllerInput.value.copyWith(
        text: text,
        composing: TextRange.empty,
      );
    });
  }

  @override
  void dispose() {
    focusInput.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    controllerInput.value = controllerInput.value.copyWith(
      text: getNickNameCard(),
    );
    super.didChangeDependencies();
  }

  PaymentMethodData? getCurrentPrimaryCard(BuildContext context) {
    return BlocProvider.of<PaymentMethodBloc>(context).state.currentPayment;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorsConstant.cFFE3E4E8,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 3,
            child: Column(
              children: <Widget>[
                Focus(
                  onFocusChange: (bool isFocused) {
                    setState(() {
                      _showSavingButton = !_showSavingButton;
                    });
                  },
                  child: TextFormField(
                    controller: controllerInput,
                    focusNode: focusInput,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Image.network(
                      widget.paymentItem.paymentType?.icon ?? '',
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
                    Text('***${widget.paymentItem.cardLastDigits}'),
                  ],
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: SizedBox(
              height: 80.h,
              child: _showSavingButton
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomButton(
                          params: CustomButtonParams.primary(
                            text: S(context).save,
                            textStyle: StylesConstant.ts12w400
                                .copyWith(color: ColorsConstant.cWhite),
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              bloc.add(
                                EditPaymentMethodEvent(
                                  id: widget.paymentItem.id ?? '',
                                  name: controllerInput.text,
                                  messageError: S(context).error_message,
                                  messageSuccess:
                                      S(context).update_card_success,
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                focusInput.requestFocus();
                              },
                              child: SvgPicture.asset(SvgAssets.icEditLinear),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                PaymentMethodData? currentPayment =
                                    getCurrentPrimaryCard(context);
                                bool isPrimaryCard =
                                    currentPayment?.id == widget.paymentItem.id;
                                String messageError = isPrimaryCard
                                    ? S(context).message_delete_primary_card
                                    : S(context).message_delete_card;
                                String title = isPrimaryCard
                                    ? S(context).delete_primary_card
                                    : S(context).delete_card;
                                showCustomModalBottomSheet(
                                  context: context,
                                  content: ConfirmDeletePaymentWidget(
                                    title: title,
                                    message: messageError,
                                    onConfirm: () {
                                      bloc.add(
                                        DeletePaymentMethodEvent(
                                          paymentId:
                                              widget.paymentItem.id ?? '',
                                          messageError:
                                              S(context).error_message,
                                          messageSuccess:
                                              getDeleteMessageSuccess(),
                                          isPrimaryCard: isPrimaryCard,
                                          userId: getIt<UserRepo>()
                                              .getCurrentUser()
                                              .id,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                              child: SvgPicture.asset(SvgAssets.icDelete),
                            ),
                          ],
                        )
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
