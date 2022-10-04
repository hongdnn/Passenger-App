import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/data/model/payment_method_model.dart';
import 'package:passenger/features/payment/data/model/payment_type_model.dart';
import 'package:passenger/features/payment/presentation/bloc_payment_method/payment_method_bloc.dart';
import 'package:passenger/features/user/data/repo/user_repo.dart';
import 'package:passenger/util/android_google_maps_back_mixin.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/card_util.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';
import 'package:passenger/util/util.dart';
import 'package:passenger/util/widgets/custom_button.dart';
import 'package:passenger/util/widgets/custom_dialog.dart';
import 'package:passenger/util/widgets/dropdown_alert/data_alert.dart';

import 'presentation/widget/card_formatter.dart';
import 'presentation/widget/input_card_widget.dart';
import 'package:collection/collection.dart';

enum ErrorMessage { empty, invalid }

class CreatePaymentMethodPage extends StatefulWidget {
  const CreatePaymentMethodPage({Key? key}) : super(key: key);

  static const String routeName = '/createPaymentMethodPage';

  @override
  State<CreatePaymentMethodPage> createState() =>
      _CreatePaymentMethodPageState();
}

class _CreatePaymentMethodPageState extends State<CreatePaymentMethodPage>
    with AndroidGoogleMapsBackMixin<CreatePaymentMethodPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey keyCardName = GlobalKey();
  final GlobalKey keyCardNumber = GlobalKey();
  final GlobalKey keyCardDate = GlobalKey();
  final GlobalKey keyCardCVV = GlobalKey();
  final GlobalKey keyCardNickName = GlobalKey();
  late PaymentMethodBloc paymentMethodBloc;

  @override
  void initState() {
    super.initState();
    paymentMethodBloc = BlocProvider.of<PaymentMethodBloc>(context);
  }

  String getPaymentCardTypeName(CardType type) {
    switch (type) {
      case CardType.jcb:
        return 'JCB';
      case CardType.visa:
        return 'Visa';
      default:
        return 'Master Card';
    }
  }

  void validateAllFiled() {
    (keyCardName.currentState as InputCardState).validateField();
    (keyCardNumber.currentState as InputCardState).validateField();
    (keyCardDate.currentState as InputCardState).validateField();
    (keyCardCVV.currentState as InputCardState).validateField();
  }

  void handleCreatePaymentMethod() {
    String cardName = (keyCardName.currentState as InputCardState).getValue();
    String cardNumber =
        (keyCardNumber.currentState as InputCardState).getValue();
    String cardDate = (keyCardDate.currentState as InputCardState).getValue();
    String cardCvv = (keyCardCVV.currentState as InputCardState).getValue();
    String cardNickName =
        (keyCardNickName.currentState as InputCardState).getValue();
    List<String> arrDate = cardDate.split('/');
    int cardExpiryMonth = 0, cardExpiryYear = 0;
    if (arrDate.length > 1) {
      cardExpiryMonth = int.parse(arrDate[0]);
      cardExpiryYear = int.parse(arrDate[1]);
    }
    //handle get card type from number card
    CardType cardType = CardUtil.getCardTypeFrmNumber(cardNumber);
    if (cardType == CardType.master ||
        cardType == CardType.jcb ||
        cardType == CardType.visa) {
      String paymentCardTypeStr = getPaymentCardTypeName(cardType);
      PaymentType? paymentCardType =
          paymentMethodBloc.state.listPaymentType?.firstWhereOrNull(
        (PaymentType element) =>
            element.name?.toLowerCase() == paymentCardTypeStr.toLowerCase(),
      );

      PaymentRequestBody payload = PaymentRequestBody(
        userId: getIt<UserRepo>().getCurrentUser().id,
        name: cardName.toUpperCase(),
        cardNum: cardNumber.replaceAll('-', ''),
        cardExpiryMonth: cardExpiryMonth,
        cardExpiryYear: cardExpiryYear,
        order: 0,
        cardCvv: cardCvv,
        nickname: cardNickName,
        paymentTypeId: paymentCardType?.id ?? '',
      );
      if (paymentCardType?.id != null) {
        paymentMethodBloc.add(CreatePaymentMethodEvent(payload));
      } else {
        alertDropdownNotify(
          S(context).error_common_msg,
          '',
          TypeAlert.error,
        );
      }
    } else {
      alertDropdownNotify(
        'Only MasterCard, Visa and JCB cards are supported',
        '',
        TypeAlert.error,
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstant.cWhite,
      appBar: AppBar(
        title: Text(S(context).add_card),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => popBack(context),
          icon: SvgPicture.asset(SvgAssets.icBackIos),
        ),
      ),
      body: BlocListener<PaymentMethodBloc, PaymentMethodState>(
        listener: (BuildContext context, PaymentMethodState state) {
          if (state.createPaymentMethodState == LoadState.success) {
            showCustomDialog(
              context: context,
              options: CustomDialogParams(
                title: S(context).add_card_success,
                message: S(context).you_have_success,
                positiveParams: CustomDialogButtonParams(
                  title: S(context).agree,
                  hasGradient: true,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    S(context).card_information,
                    style: StylesConstant.ts18w500,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  InputCard(
                    key: keyCardName,
                    hintText: '${S(context).card_name}*',
                    validateType: ValidateType.name,
                    validatorFunc: (String? value) {
                      if (value == null || value.isEmpty) {
                        return ErrorMessage.empty.toString();
                      }
                      return null;
                    },
                  ),
                  InputCard(
                    key: keyCardNumber,
                    hintText: '${S(context).card_number}*',
                    labelText: S(context).card_number,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      CardNumberFormatter()
                    ],
                    maxLength: 19,
                    validateType: ValidateType.cardNumber,
                    validatorFunc: (String? value) {
                      if (value == null || value.isEmpty) {
                        return ErrorMessage.empty.toString();
                      }
                      if (!CardUtil.validateCardNumWithLuhnAlgorithm(
                        value,
                      )) {
                        return ErrorMessage.invalid.toString();
                      }

                      return null;
                    },
                  ),
                  InputCard(
                    key: keyCardDate,
                    hintText: '${S(context).card_expired}*',
                    labelText: S(context).card_expired,
                    keyboardType: TextInputType.number,
                    validateType: ValidateType.date,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      CardMonthInputFormatter()
                    ],
                    maxLength: 5,
                    validatorFunc: (String? value) {
                      if (value == null || value.isEmpty) {
                        return ErrorMessage.empty.toString();
                      }
                      if (!CardUtil.validateDate(
                        value,
                      )) {
                        return ErrorMessage.invalid.toString();
                      }
                      return null;
                    },
                  ),
                  InputCard(
                    key: keyCardCVV,
                    hintText: '${S(context).code_on_the_back_card}*',
                    labelText: S(context).code_on_the_back_card,
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                    validateType: ValidateType.cvv,
                    validatorFunc: (String? value) {
                      if (value == null || value.isEmpty) {
                        return ErrorMessage.empty.toString();
                      }
                      if (!CardUtil.validateCVV(
                        value,
                      )) {
                        return ErrorMessage.invalid.toString();
                      }
                      return null;
                    },
                  ),
                  InputCard(
                    key: keyCardNickName,
                    hintText: S(context).name_of_card,
                    labelText: S(context).name_of_card,
                  ),
                  SizedBox(height: 30.h),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      S(context).message_add_card,
                      textAlign: TextAlign.center,
                      style: StylesConstant.ts16w400
                          .copyWith(color: ColorsConstant.cFF454754),
                    ),
                  ),
                  SizedBox(height: 56.h),
                  Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    child: CustomButton(
                      params: CustomButtonParams.primary(
                        text: S(context).add_card,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            handleCreatePaymentMethod();
                          } else {
                            validateAllFiled();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
