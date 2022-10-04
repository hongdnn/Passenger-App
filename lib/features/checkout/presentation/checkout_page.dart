import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/data/model/booking_order_model.dart';
import 'package:passenger/features/booking_page/data/model/upsert_draft_booking_model.dart';
import 'package:passenger/features/booking_page/presentation/bloc/booking_page_bloc.dart';
import 'package:passenger/features/booking_page/presentation/booking_page.dart';
import 'package:passenger/features/checkout/presentation/bloc/checkout_page_bloc.dart';
import 'package:passenger/features/checkout/presentation/util/checkout_page_ext.dart';
import 'package:passenger/features/checkout/presentation/widget/advanced_booking_time_content.dart';
import 'package:passenger/features/checkout/presentation/widget/mini_map_widget.dart';
import 'package:passenger/features/checkout/presentation/widget/payment_method_content.dart';
import 'package:passenger/features/checkout/presentation/widget/trip_location_info_widget.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
import 'package:passenger/features/landing_page/presentation/bloc/landing_page_bloc.dart';
import 'package:passenger/features/checkout/presentation/widget/add_note_to_driver_widget.dart';
import 'package:passenger/features/payment/presentation/bloc_payment_method/payment_method_bloc.dart';
import 'package:passenger/features/promotion/data/model/promotion_model.dart';
import 'package:passenger/features/promotion/data/model/promotion_infor.dart';
import 'package:passenger/features/promotion/presentation/promotion_page.dart';
import 'package:passenger/features/tracking_page/tracking_page.dart';
import 'package:passenger/features/user/data/repo/user_repo.dart';
import 'package:passenger/main.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/string_constant.dart';
import 'package:passenger/util/styles.dart';
import 'package:passenger/util/widgets/custom_button.dart';
import 'package:passenger/util/widgets/custom_dialog.dart';
import 'package:passenger/util/widgets/custom_switch.dart';
import 'package:passenger/util/widgets/error_empty_result_widget.dart';
import 'package:passenger/util/widgets/show_modal_bottom_sheet.dart';

class CheckoutArg {
  CheckoutArg({
    this.carName,
    this.promotionInfor,
  });

  String? carName;
  PromotionInfor? promotionInfor;
}

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key, required this.args}) : super(key: key);
  final CheckoutArg args;
  static const String routeName = 'checkoutConfirmation';

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final EdgeInsets kDefaultPadding = EdgeInsets.symmetric(
    vertical: 4.w,
    horizontal: 8.w,
  );
  ValueNotifier<bool> valueSelectRobinhoodCoin = ValueNotifier<bool>(false);
  ValueNotifier<double> valueRbhCoinAfterDiscount = ValueNotifier<double>(0);
  ValueNotifier<bool> valueSelectPromotionItem = ValueNotifier<bool>(false);

  final NumberFormat formatter = NumberFormat('#.#');

  late CheckoutPageBloc _checkoutPageBloc;

  @override
  void initState() {
    _checkoutPageBloc = getIt();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _checkoutPageBloc.add(
        GetDraftingTripByDeviceIdEvent(
          deviceId: getIt<UserRepo>().getCurrentUser().id,
        ),
      );
      BlocProvider.of<PaymentMethodBloc>(context).add(
        GetInfoPaymentEvent(getIt<UserRepo>().getCurrentUser().id),
      );
      BlocProvider.of<PaymentMethodBloc>(context).add(
        GetAllPaymentTypeEvent(),
      );
      _checkoutPageBloc.add(
        GetPromotionEvent(),
      );
      BlocProvider.of<LandingPageBloc>(context).add(
        CheckBookingAvailabilityEvent(),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstant.cFFF7F7F8,
      appBar: AppBar(
        title: Text(
          S(context).checkout_confirmation_title,
          style: StylesConstant.ts20w500,
        ),
        centerTitle: true,
      ),
      body: BlocProvider<CheckoutPageBloc>(
        create: (BuildContext context) => _checkoutPageBloc,
        child: BlocBuilder<CheckoutPageBloc, CheckoutPageState>(
          buildWhen: (CheckoutPageState previous, CheckoutPageState current) {
            return previous.loadDraftTripDataStatus !=
                current.loadDraftTripDataStatus;
          },
          builder: (_, CheckoutPageState state) {
            if (state.loadDraftTripDataStatus == LoadState.loading ||
                state.loadDraftTripDataStatus == LoadState.none) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (state.loadDraftTripDataStatus == LoadState.failure) {
              return const Center(
                child: ErrorOrEmptyResultWidget(
                  errorMessage: StringConstant.loadDraftTripFailed,
                ),
              );
            }
            if (state.draftTripData == null) {
              return const Center(
                child: ErrorOrEmptyResultWidget(
                  errorMessage: StringConstant.loadDraftTripFailed,
                ),
              );
            }
            return SizedBox.expand(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: BlocListener<BookingPageBloc, BookingPageState>(
                  listenWhen: (
                    BookingPageState previous,
                    BookingPageState current,
                  ) =>
                      previous.bookingOrderModel?.status !=
                      current.bookingOrderModel?.status,
                  listener:
                      (BuildContext context, BookingPageState stateBuilder) {
                    if (stateBuilder.bookingOrderModel!.status == 1000) {
                      Navigator.pushNamed(
                        context,
                        TrackingPage.routeName,
                        arguments: TrackingArgs(
                          bookingId:
                              stateBuilder.bookingOrderModel?.data?.id ?? '',
                          advancedBookingTime: state.draftTripData?.startTime !=
                                  null
                              ? DateTime.parse(state.draftTripData!.startTime!)
                              : null,
                          isDriverFound: false,
                          listLocationRequest: List<LocationRequest>.generate(
                            state.draftTripData!.locations!.length,
                            (int index) => LocationRequest.fromTripLocation(
                              state.draftTripData!.locations![index],
                            ),
                          ),
                          bookingOrderModel: stateBuilder.bookingOrderModel,
                          distance: state.draftTripData?.distance,
                          timeEst: state.draftTripData?.totalTime?.toDouble(),
                          price: _checkoutPageBloc.getTotalPrice(),
                          isBookingNow: !(state.draftTripData!.isTripLater!),
                          isLandingPageNavTo: false,
                        ),
                      );
                    } else {
                      showCustomDialog(
                        context: context,
                        options: CustomDialogParams.simpleAlert(
                          title: S(context).unable_to_continue,
                          message:
                              stateBuilder.bookingOrderModel?.errorMessage ??
                                  '',
                          onPressed: () {
                            Navigator.popUntil(
                              context,
                              (Route<dynamic> route) =>
                                  route.settings.name == BookingPage.routeName,
                            );
                          },
                          negativeTitle: S(context).agree,
                        ),
                      );
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _header(state),
                      state.draftTripData?.startTime != null
                          ? AdvancedBookingTimeContent(
                              advancedBookingTime: DateTime.parse(
                                state.draftTripData!.startTime!,
                              ),
                            )
                          : const SizedBox(),
                      ..._buildOderSummary(state),
                      const PaymentMethodContent(),
                      _nextBtn(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _header(CheckoutPageState state) {
    return Container(
      padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 8.h, bottom: 16.h),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          MiniMapWidget(
            tripLocation: state.draftTripData?.locations ?? <TripLocation>[],
          ),
          SizedBox(height: 16.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              S(context).travel,
              style: StylesConstant.ts16w500,
            ),
          ),
          SizedBox(height: 8.h),
          TripLocationInfoWidget(
            tripLocation: state.draftTripData?.locations ?? <TripLocation>[],
          ),
          _note(),
          const Divider(
            height: 1,
            color: ColorsConstant.cFFE3E4E8,
          ),
          SizedBox(height: 16.h),
          _timeAndDistance(state),
        ],
      ),
    );
  }

  Widget _note() {
    return BlocBuilder<CheckoutPageBloc, CheckoutPageState>(
      buildWhen: (_, CheckoutPageState current) {
        return current.status == CheckoutPageStatus.addNoteToDriver;
      },
      builder: (BuildContext context, CheckoutPageState state) {
        return InkWell(
          onTap: () {
            _onAddNote(state.note);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h).copyWith(left: 36.w),
            child: state.isNoteValid()
                ? Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          state.note!,
                          style: StylesConstant.ts14w400.copyWith(
                            color: ColorsConstant.cFF73768C,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        S(context).edit,
                        style: StylesConstant.ts14w500.copyWith(
                          color: ColorsConstant.cFFA33AA3,
                        ),
                      )
                    ],
                  )
                : Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        SvgAssets.icAddNote,
                        height: 20.h,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        S(context).add_note_to_driver,
                        style: StylesConstant.ts14w500.copyWith(
                          color: ColorsConstant.cFFA33AA3,
                        ),
                      )
                    ],
                  ),
          ),
        );
      },
    );
  }

  Container _nextBtn() {
    return Container(
      height: 76.h,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: BlocBuilder<BookingPageBloc, BookingPageState>(
        builder: (_, BookingPageState stateBuilder) {
          return BlocBuilder<LandingPageBloc, LandingPageState>(
            builder: (_, LandingPageState landingState) {
              return BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
                builder: (_, PaymentMethodState statePayment) {
                  return CustomButton(
                    params: CustomButtonParams.primary(
                      onPressed: () {
                        landingState.checkBookingAvailabilityModel != null &&
                                landingState.checkBookingAvailabilityModel!
                                    .data!.isAvailable!
                            ? _onPressConfirm(
                                context,
                                stateBuilder,
                                statePayment,
                              )
                            : showCustomDialog(
                                context: context,
                                options: CustomDialogParams.simpleAlert(
                                  title: S(context).unable_to_continue,
                                  message: landingState
                                          .checkBookingAvailabilityModel
                                          ?.errorMessage ??
                                      '',
                                  onPressed: () {
                                    Navigator.popUntil(
                                      context,
                                      (Route<dynamic> route) =>
                                          route.settings.name ==
                                          MyHomePage.routeName,
                                    );
                                  },
                                  negativeTitle: S(context).agree,
                                ),
                              );
                      },
                      text: S(context).checkout_confirmation_button,
                    ).copyWith(
                      padding: kDefaultPadding,
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  void _onPressConfirm(
    BuildContext context,
    BookingPageState stateBuilder,
    PaymentMethodState statePayment,
  ) {
    showDialog(
      context: context,
      builder: (_) => const CupertinoActivityIndicator(
        color: Colors.white,
      ),
    );
    final PromotionData promotionData = _checkoutPageBloc.getPromotionItem();
    BlocProvider.of<BookingPageBloc>(context).add(
      ConfirmBookingOrderEvent(
        ConfirmBookingRequestModel(
          userId: BlocProvider.of<BookingPageBloc>(context).getCurrentUser().id,
          tripId: stateBuilder.upsertDraftBookingModel?.data?.id ?? '',
          paymentMethodId: statePayment.currentPayment?.id ??
              '090eb19e-6239-4c38-a1de-db75de2c88f2',
          promotion: promotionData.isPromotionValid()
              ? Promotion(
                  promotionId: promotionData.promotionId,
                  promotionCode: promotionData.promotionCode,
                  voucherCode: promotionData.voucherCode,
                )
              : null,
        ),
      ),
    );
  }

  Widget _timeAndDistance(CheckoutPageState state) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              S(context).distance,
              style: StylesConstant.ts16w400,
            ),
            Text(
              '${state.draftTripData!.distance!} ${S(context).km}',
              style: StylesConstant.ts16w500,
            )
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              S(context).travel_time,
              style: StylesConstant.ts16w400,
            ),
            Text(
              '''${state.draftTripData!.totalTime!.toInt()} ${S(context).min}''',
              style: StylesConstant.ts16w500,
            )
          ],
        ),
      ],
    );
  }

  void _onAddNote(String? note) {
    showCustomModalBottomSheet(
      context: context,
      barrierDismissible: false,
      enableDrag: false,
      content: AddNoteToDriverWidget(
        initialNote: note,
        onSaveNote: (String? note) {
          _onSaveNote(note);
        },
      ),
    );
  }

  void _onSaveNote(String? note) {
    _checkoutPageBloc.add(AddNoteToDriverEvent(note: note));
  }

  _buildOderSummary(CheckoutPageState state) {
    return <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w)
            .copyWith(top: 24.w, bottom: 8.w),
        child: Text(
          S(context).order_summary,
          style: StylesConstant.ts16w500.copyWith(
            color: ColorsConstant.cFF454754,
          ),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.args.carName.toString(),
                    style: StylesConstant.ts16w400,
                  ),
                  Text(
                    '${state.draftTripData?.price ?? ''}',
                    style: StylesConstant.ts16w500,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              const Divider(
                height: 1,
                color: ColorsConstant.cFFE3E4E8,
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    S(context).subtotal,
                    style: StylesConstant.ts16w400,
                  ),
                  Text(
                    '${state.draftTripData?.price ?? ''}',
                    style: StylesConstant.ts16w500,
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              ValueListenableBuilder<bool>(
                valueListenable: valueSelectPromotionItem,
                builder: (
                  BuildContext context,
                  bool selectedPromotionItem,
                  Widget? newValue,
                ) {
                  return InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      _onClickPromotionBt(context, state);
                    },
                    child: BlocBuilder<CheckoutPageBloc, CheckoutPageState>(
                      builder: (BuildContext context, CheckoutPageState state) {
                        if (state.getPromotionStatus == LoadState.loading &&
                            selectedPromotionItem == false) {
                          return _promotionContent(
                            context: context,
                            svgAsset: SvgAssets.icAddNote,
                            promoTitle: S(context).promo,
                          );
                        }
                        final double price =
                            widget.args.promotionInfor?.discountAmount ?? 0;
                        return _promotionContent(
                          context: context,
                          svgAsset: SvgAssets.icMinusNote,
                          promoTitle:
                              state.promotionListItem?.promotionName ?? '',
                          price: price.toPrecision().toString(),
                        );
                      },
                    ),
                  );
                },
              ),
              SizedBox(
                height: 16.h,
              ),
              const Divider(
                height: 1,
                color: ColorsConstant.cBlack,
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SvgPicture.asset(SvgAssets.icRbhCoins),
                  SizedBox(
                    width: 8.w,
                  ),
                  Flexible(
                    child: Text(
                      '''${S(context).use} Robinhood coins 100.00 \$RBH \n${S(context).balance} 100.00 \$RBH\n(1 \$RBH = ฿1)''',
                      style: StylesConstant.ts16w400.copyWith(
                        color: ColorsConstant.cFF73768C,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: valueSelectRobinhoodCoin,
                    builder: (
                      BuildContext context,
                      bool selectedRbhCoin,
                      Widget? newValue,
                    ) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          CustomSwitch(
                            value: selectedRbhCoin,
                            onChanged: (bool value) {
                              valueSelectRobinhoodCoin.value = value;
                              _checkoutPageBloc.add(
                                GetRbhCoinDiscountEvent(
                                  rbhCoinDiscount: 100.00,
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          selectedRbhCoin == true
                              ? Text(
                                  '''-${valueRbhCoinAfterDiscount.value.toString()}''',
                                  style: StylesConstant.ts16w500.copyWith(
                                    color: ColorsConstant.cFFA33AA3,
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              const Divider(
                height: 1,
                color: ColorsConstant.cFFE3E4E8,
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    S(context).total,
                    style: StylesConstant.ts16w500.copyWith(
                      color: ColorsConstant.cFFA33AA3,
                    ),
                  ),
                  BlocBuilder<CheckoutPageBloc, CheckoutPageState>(
                    builder: (BuildContext context, CheckoutPageState state) {
                      final String totalPrice = getTotalPrice(
                        valueSelectPromotionItem:
                            valueSelectPromotionItem.value,
                        promotionData: state.promotionListItem,
                        discountPromo:
                            (widget.args.promotionInfor?.discountAmount ?? 0)
                                .toPrecision(),
                        originalPrice:
                            (state.draftTripData?.price ?? 0).toDouble(),
                      );
                      _checkoutPageBloc.add(
                        GetTotalPriceEvent(
                          totalPrice: double.parse(totalPrice),
                        ),
                      );
                      return Text(
                        '฿${state.totalPrice}',
                        style: StylesConstant.ts20w500.copyWith(
                          color: ColorsConstant.cFFA33AA3,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ];
  }

  void _onClickPromotionBt(BuildContext context, CheckoutPageState state) {
    if (valueSelectPromotionItem.value == false) {
      Navigator.pushNamed(
        context,
        PromotionPage.routeName,
        arguments: PromotionPageArg(
          tripPrice: (state.draftTripData?.price ?? 0).toDouble(),
        ),
      ).then((_) {
        final CheckoutArg arguments =
            ModalRoute.of(context)?.settings.arguments as CheckoutArg;
        valueSelectPromotionItem.value =
            arguments.promotionInfor?.promotionData != null;
        _checkoutPageBloc.add(
          GetPromotionEvent(
            promotionListItem: arguments.promotionInfor?.promotionData,
            selectedPromotionItem: valueSelectPromotionItem.value,
          ),
        );
      });
    } else {
      _checkoutPageBloc.add(
        GetPromotionEvent(
          selectedPromotionItem: valueSelectPromotionItem.value,
        ),
      );
      valueSelectPromotionItem.value = false;
    }
  }

  Row _promotionContent({
    required BuildContext context,
    required String svgAsset,
    required String promoTitle,
    String? price,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            SvgPicture.asset(svgAsset),
            SizedBox(
              width: 8.w,
            ),
            Text(
              promoTitle,
              style: StylesConstant.ts16w400.copyWith(
                color: ColorsConstant.cFFA33AA3,
              ),
            ),
          ],
        ),
        price == null
            ? const SizedBox.shrink()
            : Text(
                '-$price',
                style: StylesConstant.ts16w500.copyWith(
                  color: ColorsConstant.cFFA33AA3,
                ),
              ),
      ],
    );
  }
}
