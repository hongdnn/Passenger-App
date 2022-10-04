import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/data/model/payment_method_model.dart';
import 'package:passenger/features/payment/create_payment_method_page.dart';
import 'package:passenger/features/payment/presentation/editing_payment_method_page.dart';
import 'package:passenger/features/payment/presentation/widget/confirm_select_payment_widget.dart';
import 'package:passenger/features/user/data/repo/user_repo.dart';
import 'package:passenger/util/android_google_maps_back_mixin.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';
import 'package:passenger/util/widgets/custom_button.dart';
import 'package:passenger/util/widgets/show_modal_bottom_sheet.dart';

import 'bloc_payment_method/payment_method_bloc.dart';

class ListPaymentMethodArg {
  ListPaymentMethodArg({this.paymentSelected = 'scb', this.onTap});

  final String paymentSelected;
  final Function(String cardId)? onTap;
}

abstract class PaymentItem {
  Widget buildMethodPayment(BuildContext context);

  Widget buildPaymentItem(BuildContext context);
}

class PaymentCardItem {
  PaymentCardItem({
    required this.id,
    this.icon,
    this.image,
    required this.name,
    required this.onTap,
    this.numberCard,
  });

  final String id;
  final String? icon;
  final String? image;
  final String name;
  final VoidCallback onTap;
  final String? numberCard;
}

class ListPaymentMethodPage extends StatefulWidget {
  const ListPaymentMethodPage({Key? key, required this.listPaymentMethodArg})
      : super(key: key);

  static const String routeName = '/listPaymentMethodPage';

  final ListPaymentMethodArg listPaymentMethodArg;

  @override
  State<ListPaymentMethodPage> createState() => _ListPaymentMethodPageState();
}

class _ListPaymentMethodPageState extends State<ListPaymentMethodPage>
    with AndroidGoogleMapsBackMixin<ListPaymentMethodPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _handleAddPaymentMethod() {
    Navigator.pushNamed(context, CreatePaymentMethodPage.routeName);
    // Navigator.pushNamed(context, CreatePaymentMethod.);
  }

  void _handleHelp() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstant.cWhite,
      appBar: AppBar(
        title: Text(S(context).payment_methods),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            popBack(context);
          },
          icon: SvgPicture.asset(SvgAssets.icBackIos),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(EditingPaymentMethodPage.routeName);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.edit),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            children: <Widget>[
              BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
                builder: (BuildContext context, PaymentMethodState state) {
                  return Column(
                    children: <Widget>[
                      if (state.allPaymentItemsState == LoadState.loading)
                        const CupertinoActivityIndicator(),
                      if (state.allPaymentItemsState == LoadState.failure)
                        Text(S(context).error_common_msg),
                      ListPayment(
                        items: List<PaymentItem>.generate(
                          state.listPaymentItem.length,
                          (int index) {
                            PaymentMethodData item =
                                state.listPaymentItem[index];
                            bool isSelected =
                                item.id == state.currentPayment?.id;
                            return PaymentMethodIem(
                              card: item,
                              isSelected: isSelected,
                              bloc: BlocProvider.of<PaymentMethodBloc>(context),
                              onTap: widget.listPaymentMethodArg.onTap,
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
              GestureDetector(
                onTap: _handleAddPaymentMethod,
                child: Container(
                  margin: EdgeInsets.only(top: 32.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorsConstant.cFFA33AA3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: <Widget>[
                      SvgPicture.asset(SvgAssets.icPlusBt),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        S(context).add_payment_method,
                        style: StylesConstant.ts16w400,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    SvgAssets.icPaymentVisa,
                    width: 24.w,
                    height: 12.h,
                  ),
                  SizedBox(width: 16.w),
                  SvgPicture.asset(
                    SvgAssets.icPaymentMasterCard,
                    width: 24.w,
                    height: 12.h,
                  ),
                  SizedBox(width: 16.w),
                  Image.asset(
                    PngAssets.icPaymentJSB,
                    width: 24.w,
                    height: 12.h,
                  )
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              GestureDetector(
                onTap: _handleHelp,
                child: Text(
                  S(context).help,
                  style: StylesConstant.ts16w400.copyWith(
                    color: ColorsConstant.cFFA33AA3,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ListPayment extends StatelessWidget {
  const ListPayment({super.key, required this.items});

  final List<PaymentItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            items[index].buildMethodPayment(context),
            items[index].buildPaymentItem(context),
          ],
        );
      },
    );
  }
}

class PaymentMethodIem implements PaymentItem {
  PaymentMethodIem({
    required this.card,
    this.isSelected = false,
    required this.bloc,
    this.onTap,
  });

  final PaymentMethodData card;
  final bool isSelected;

  final PaymentMethodBloc bloc;
  final Function(String cardId)? onTap;

  @override
  Widget buildMethodPayment(BuildContext context) {
    return const SizedBox();
  }

  Widget buildPaymentMethodItem(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      decoration: BoxDecoration(
        border: Border.all(
          color:
              isSelected ? ColorsConstant.cFFA33AA3 : ColorsConstant.cFFE3E4E8,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          if (card.paymentType?.icon != null)
            Image.network(
              card.paymentType?.icon ?? '',
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
          SizedBox(width: 16.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 2.w),
              child: Text(
                card.paymentType?.name ?? '',
                style: StylesConstant.ts16w400
                    .copyWith(color: ColorsConstant.cFF454754),
                maxLines: 4,
              ),
            ),
          ),
          if (isSelected)
            CustomButton(
              params: CustomButtonParams.primary(
                text: S(context).primary_card,
                textStyle: StylesConstant.ts12w400
                    .copyWith(color: ColorsConstant.cWhite),
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 18.w),
              ),
            )
        ],
      ),
    );
  }

  Widget buildPaymentCardItem(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        border: Border.all(
          color:
              isSelected ? ColorsConstant.cFFA33AA3 : ColorsConstant.cFFE3E4E8,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  card.nickname == '' ? card.name! : card.nickname!,
                  style: StylesConstant.ts16w400
                      .copyWith(color: ColorsConstant.cFF454754),
                ),
              ),
              if (isSelected)
                CustomButton(
                  params: CustomButtonParams.primary(
                    text: S(context).primary_card,
                    textStyle: StylesConstant.ts12w400
                        .copyWith(color: ColorsConstant.cWhite),
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 18.w),
                  ),
                )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: <Widget>[
              if (card.paymentType?.icon != null)
                Image.network(
                  card.paymentType?.icon ?? '',
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
              // SvgPicture.asset(SvgAssets.icPaymentMasterCard),
              Expanded(
                child: Text(
                  '****${card.cardLastDigits}',
                  textAlign: TextAlign.right,
                  style: StylesConstant.ts14w400
                      .copyWith(color: ColorsConstant.cFF73768C),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget buildPaymentItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCustomModalBottomSheet(
          context: context,
          content: ConfirmSelectPaymentWidget(
            onConfirm: () {
              if (onTap != null) {
                onTap?.call(card.id ?? '');
              } else {
                bloc.add(
                  SelectPaymentMethodEvent(
                    card.id ?? '',
                    getIt<UserRepo>().getCurrentUser().id,
                  ),
                );
              }
            },
          ),
        );
      },
      child: Container(
        child:
            card.paymentType?.isCard != null && card.paymentType?.isCard == true
                ? buildPaymentCardItem(context)
                : buildPaymentMethodItem(context),
      ),
    );
  }
}
