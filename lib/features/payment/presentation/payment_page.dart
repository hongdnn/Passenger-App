import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/data/model/invoice_model.dart';
import 'package:passenger/features/booking_page/data/model/payment_method_model.dart';
import 'package:passenger/features/booking_page/data/model/upsert_draft_booking_model.dart';
import 'package:passenger/features/driver_rating/presentation/driver_rating_page.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
import 'package:passenger/features/payment/data/model/update_booking_model.dart';
import 'package:passenger/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:passenger/features/payment/presentation/list_payment_method_page.dart';
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

class PaymentArg {
  PaymentArg({
    this.listLocation,
    this.bookingId,
  });

  List<LocationRequest>? listLocation;
  String? bookingId;
}

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key, required this.args}) : super(key: key);
  final PaymentArg? args;
  static const String routeName = '/paymentPage';

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<LocationRequest> mockListLocationTest = <LocationRequest>[];
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  @override
  void initState() {
    mockListLocationTest
        .addAll(widget.args?.listLocation ?? <LocationRequest>[]);
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<PaymentBloc>(context).add(
        GetInvoiceByIdBookingEvent(
          InvoiceRequestBody(
            userId: getIt<UserRepo>().getCurrentUser().id,
            note: 'string',
            bookingId: widget.args!.bookingId,
          ),
        ),
      );
    });
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

  Widget _buildLoadingIndicator() {
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (_, PaymentState state) {
        if (state.processInvoiceStatus == LoadState.success) {
          showCustomDialog(
            context: context,
            options: CustomDialogParams(
              title: S(context).success_payment,
              message: S(context).thanks_for_your_pay,
              positiveParams: CustomDialogButtonParams(
                hasGradient: true,
                title: S(context).agree,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    DriverRatingPage.routeName,
                    arguments: DriverRatingPageArgs(
                      bookingId: state.invoiceModel?.data?.booking?.id ?? '',
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
      child: Container(
        color: ColorsConstant.cWhite,
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(top: 58.h),
          child: Column(
            children: <Widget>[
              RotationTransition(
                turns: Tween<double>(begin: 0.0, end: 1.0).animate(_controller),
                child: SvgPicture.asset(
                  SvgAssets.icTimeClock,
                  height: 148.h,
                ),
              ),
              SizedBox(
                height: 70.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 82.w),
                child: Text(
                  S(context).payment_message,
                  textAlign: TextAlign.center,
                  style: StylesConstant.ts20w400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getPromotionAmount(PaymentState state) {
    return '-${state.invoiceModel?.data?.booking?.promotionAmount}';
  }

  String getLastCardNumber(PaymentState state) {
    PaymentMethodData? paymentMethod =
        state.invoiceModel?.data?.booking?.paymentMethod;
    if (paymentMethod?.cardLastDigits == null) {
      return '';
    }
    return '***${paymentMethod?.cardLastDigits}';
  }

  Widget _buildOderSummary() {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (_, PaymentState state) {
        return Column(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 24.w, top: 24.h),
                child: Text(
                  S(context).order_summary,
                  style: StylesConstant.ts16w500.copyWith(
                    color: ColorsConstant.cFF454754,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
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
                          state.invoiceModel?.data?.booking?.carInfo?.carType
                                  ?.typeName
                                  .toString() ??
                              '',
                          style: StylesConstant.ts16w400,
                        ),
                        Text(
                          state.invoiceModel?.data?.booking?.price.toString() ??
                              '',
                          style: StylesConstant.ts16w500,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          S(context).expressway,
                          style: StylesConstant.ts16w400,
                        ),
                        Text(
                          state.invoiceModel?.data?.booking?.expressWayFee
                                  .toString() ??
                              '',
                          style: StylesConstant.ts16w500,
                        ),
                      ],
                    ),
                    const Divider(),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          S(context).subtotal,
                          style: StylesConstant.ts16w400,
                        ),
                        Text(
                          '${state.invoiceModel?.data?.booking?.price ?? ''}',
                          style: StylesConstant.ts16w500,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          S(context).promo_newuser,
                          style: StylesConstant.ts16w400.copyWith(
                            color: ColorsConstant.cFFA33AA3,
                          ),
                        ),
                        Text(
                          // ignore: lines_longer_than_80_chars
                          '-${(state.invoiceModel?.data?.booking?.promotionAmount ?? 0).toPrecision()}',
                          style: StylesConstant.ts16w500.copyWith(
                            color: ColorsConstant.cFFA33AA3,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    const Divider(),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          S(context).total,
                          style: StylesConstant.ts16w400.copyWith(
                            color: ColorsConstant.cFFA33AA3,
                          ),
                        ),
                        Text(
                          '''฿${(state.invoiceModel?.data?.amount ?? 0).toPrecision().toString()}''',
                          style: StylesConstant.ts20w500.copyWith(
                            color: ColorsConstant.cFFA33AA3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String getPaymentName(PaymentMethodData? currentPayment) {
    if (currentPayment?.paymentType?.isCard != null &&
        currentPayment?.paymentType?.isCard == true) {
      return currentPayment?.name ?? '';
    } else {
      return currentPayment?.paymentType?.name ?? '';
    }
  }

  Widget _buildPaymentMethod() {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (BuildContext context, PaymentState state) {
        String paymentName =
            getPaymentName(state.invoiceModel?.data?.booking?.paymentMethod);
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
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ListPaymentMethodPage.routeName,
                        arguments: ListPaymentMethodArg(
                          onTap: (String cardId) {
                            BookingData? bookingData =
                                state.invoiceModel?.data?.booking;
                            UpdateBookingPayloadModel payload =
                                UpdateBookingPayloadModel(
                              userId: bookingData?.userId ?? '',
                              paymentMethodId: cardId,
                            );
                            BlocProvider.of<PaymentBloc>(context).add(
                              UpdateBookingEvent(
                                bookingData?.id ?? '',
                                payload,
                              ),
                            );
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
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
                    if (state.invoiceModel?.data?.booking?.paymentMethod
                            ?.paymentType?.icon !=
                        null)
                      Image.network(
                        state.invoiceModel?.data?.booking?.paymentMethod
                                ?.paymentType?.icon ??
                            '',
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
                      )
                    else
                      SvgPicture.asset(SvgAssets.icPaymentMasterCard),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      paymentName,
                      style: StylesConstant.ts16w400.copyWith(
                        color: ColorsConstant.cFF454754,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      getLastCardNumber(state),
                      style: StylesConstant.ts16w500.copyWith(
                        color: ColorsConstant.cFF454754,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _destinationPins() {
    List<Widget> pins = <Widget>[];
    pins.add(
      SvgPicture.asset(SvgAssets.icPin),
    );

    if (mockListLocationTest.length <= minDestinationLength) {
      pins.add(
        Column(
          children: <Widget>[
            Container(
              height: 24.h,
              padding: EdgeInsets.all(5.h),
              child: SvgPicture.asset(SvgAssets.icStripedLines),
            ),
            SvgPicture.asset(SvgAssets.icPinDestination),
          ],
        ),
      );
    } else {
      for (int i = minDestinationLength - 1;
          i < mockListLocationTest.length;
          i++) {
        pins.add(
          Column(
            children: <Widget>[
              Container(
                height: 24.h,
                padding: EdgeInsets.all(5.h),
                child: SvgPicture.asset(SvgAssets.icStripedLines),
              ),
              SvgPicture.asset(StringConstant.iconDestination[i]!),
            ],
          ),
        );
      }
    }
    return Column(
      children: pins,
    );
  }

  Widget _destinationInfos() {
    List<Widget> infos = <Widget>[];
    infos.add(_destinationItem(mockListLocationTest[0]));
    for (int i = 1; i < mockListLocationTest.length; i++) {
      infos
        ..add(
          SizedBox(height: 20.h),
        )
        ..add(_destinationItem(mockListLocationTest[i]));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: infos,
    );
  }

  Widget _destinationItem(LocationRequest locationModel) {
    return Text(
      '${locationModel.addressName} • ${locationModel.address}',
      style: StylesConstant.ts16w400,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildContent() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: ColorsConstant.cWhite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.w,
                        horizontal: 24.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            S(context).travel,
                            style: StylesConstant.ts16w500,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _destinationPins(),
                          SizedBox(width: 15.w),
                          Expanded(child: _destinationInfos()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _buildOderSummary(),
              _buildPaymentMethod(),
              const Expanded(child: SizedBox()),
              Padding(
                padding: EdgeInsets.all(24.w),
                child: BlocBuilder<PaymentBloc, PaymentState>(
                  builder: (_, PaymentState state) {
                    return CustomButton(
                      params: CustomButtonParams.primary(
                        text: S(context).confirm,
                        onPressed: () {
                          isLoading.value = true;
                          if (state.createInvoiceStatus == LoadState.success) {
                            BlocProvider.of<PaymentBloc>(context).add(
                              ProcessInvoiceEvent(
                                state.invoiceModel!.data!.id.toString(),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: ColorsConstant.cFFF7F7F8,
        appBar: AppBar(
          title: Text(
            S(context).payment,
            style: StylesConstant.ts20w500,
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.popUntil(
                context,
                (Route<dynamic> route) =>
                    route.settings.name == MyHomePage.routeName,
              );
            },
            icon: SvgPicture.asset(SvgAssets.icBackIos),
          ),
        ),
        body: ValueListenableBuilder<bool>(
          valueListenable: isLoading,
          builder: (_, bool isError, Widget? error) {
            return isLoading.value ? _buildLoadingIndicator() : _buildContent();
          },
        ),
      ),
    );
  }
}
