import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/driver_rating/data/model/request/rate_driver_request.dart';
import 'package:passenger/features/order_history/presentation/order_history_page.dart';
import 'package:passenger/features/payment/presentation/bloc_payment_method/payment_method_bloc.dart';
import 'package:passenger/features/tip_payment/data/model/request/tip_payment_invoice_req.dart';
import 'package:passenger/features/tip_payment/presentation/bloc/tip_payment_bloc.dart';
import 'package:passenger/features/tip_payment/presentation/extension/tip_payment_ext.dart';
import 'package:passenger/features/tip_payment/presentation/widgets/payment_method_widget.dart';
import 'package:passenger/features/tip_payment/presentation/widgets/tip_payment_in_progress.dart';
import 'package:passenger/features/tip_payment/presentation/widgets/title_header_widget.dart';
import 'package:passenger/features/trip_detail/presentation/widget/title_and_value_widget.dart';
import 'package:passenger/features/trip_detail/trip_detail_page.dart';
import 'package:passenger/features/user/data/repo/user_repo.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/string_constant.dart';
import 'package:passenger/util/styles.dart';
import 'package:passenger/util/widgets/custom_button.dart';
import 'package:passenger/util/widgets/custom_dialog.dart';
import 'package:passenger/util/widgets/error_empty_result_widget.dart';

class TipPaymentPageArgs {
  TipPaymentPageArgs({
    this.rateDriverRequest,
    this.isPopBack = false,
  });

  RateDriverRequest? rateDriverRequest;
  bool isPopBack;
}

class TipPaymentPage extends StatefulWidget {
  const TipPaymentPage({Key? key, this.args}) : super(key: key);
  final TipPaymentPageArgs? args;
  @override
  State<TipPaymentPage> createState() => _TipPaymentPageState();

  static const String routeName = '/tipPayment';
}

class _TipPaymentPageState extends State<TipPaymentPage> {
  ValueNotifier<bool> isProcessingTipInvoice = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _loadPaymentInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstant.cFFF7F7F8,
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: SvgPicture.asset(SvgAssets.icBackIos),
        ),
        title: Text(
          S(context).tip_payment_title_header,
          style: StylesConstant.ts20w500,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<PaymentMethodBloc, PaymentMethodState>(
        listener: (BuildContext context, PaymentMethodState state) {
          if (state.infoPaymentState == LoadState.success) {
            _upsertTipInvoice(
              paymentMethodId: state.currentPayment?.id,
              bookingId: widget.args?.rateDriverRequest?.bookingId,
            );
          } else if (state.setPaymentDefaultState == LoadState.success) {
            _upsertTipInvoice(
              paymentMethodId: state.currentPayment?.id,
              bookingId: widget.args?.rateDriverRequest?.bookingId,
            );
          }
        },
        listenWhen: (PaymentMethodState previous, PaymentMethodState current) {
          return shouldListen(previous, current);
        },
        buildWhen: (PaymentMethodState previous, PaymentMethodState current) {
          return shouldBuild(previous, current);
        },
        builder: (BuildContext context, PaymentMethodState paymentMethodState) {
          if (paymentMethodState.infoPaymentState == LoadState.loading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }

          if (paymentMethodState.infoPaymentState == LoadState.failure) {
            return Center(
              child: ErrorOrEmptyResultWidget(
                errorMessage: StringConstant.loadInfoPaymentFailed,
                actions: _retryButton(onTap: _loadPaymentInfo),
              ),
            );
          }

          return BlocListener<TipPaymentBloc, TipPaymentState>(
            listenWhen: (TipPaymentState previous, TipPaymentState current) {
              return current.processTipPaymentInvoiceState !=
                  previous.processTipPaymentInvoiceState;
            },
            listener: (BuildContext context, TipPaymentState state) {
              if (state.processTipPaymentInvoiceState == LoadState.success) {
                _onSuccessProcessInvoice();
              }
            },
            child: ValueListenableBuilder<bool>(
              valueListenable: isProcessingTipInvoice,
              builder: (_, bool isError, Widget? error) {
                return isProcessingTipInvoice.value
                    ? const TipPaymentInProgress()
                    : _buildMainContent(paymentMethodState);
              },
            ),
          );
        },
      ),
    );
  }

  _onSuccessProcessInvoice() {
    showCustomDialog(
      context: context,
      options: CustomDialogParams(
        title: S(context).success_payment,
        message: S(context).thanks_for_your_pay,
        positiveParams: CustomDialogButtonParams(
          hasGradient: true,
          title: S(context).agree,
          onPressed: () {
            _clearTipPaymentState();
            if (widget.args?.isPopBack == true) {
              Navigator.of(context).popUntil((Route<dynamic> route) {
                if (route.settings.name == TripDetailPage.routeName) {
                  (route.settings.arguments as TripDetailPageOutputArgs)
                      .reload = true;
                  return true;
                } else {
                  return false;
                }
              });
            } else {
              Navigator.pushReplacementNamed(
                context,
                OrderHistoryPage.routeName,
                arguments: OrderHistoryPageArgs(
                  currentTabIndex: OrderHistoryTabIndex.completed,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildMainContent(PaymentMethodState paymentMethodState) {
    return BlocBuilder<TipPaymentBloc, TipPaymentState>(
      builder: (BuildContext context, TipPaymentState state) {
        if (state.refreshTipPaymentInvoiceState == LoadState.loading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (state.refreshTipPaymentInvoiceState == LoadState.failure) {
          return Center(
            child: ErrorOrEmptyResultWidget(
              actions: _retryButton(
                onTap: () {
                  _upsertTipInvoice(
                    paymentMethodId: paymentMethodState.currentPayment?.id,
                    bookingId: widget.args?.rateDriverRequest?.bookingId,
                  );
                },
              ),
              errorMessage: StringConstant.loadTipInvoiceFailed,
            ),
          );
        }
        if (state.tipPaymentInvoice == null) {
          return Center(
            child: ErrorOrEmptyResultWidget(
              actions: _retryButton(
                onTap: () {
                  _upsertTipInvoice(
                    paymentMethodId: paymentMethodState.currentPayment?.id,
                    bookingId: widget.args?.rateDriverRequest?.bookingId,
                  );
                },
              ),
              errorMessage: StringConstant.loadTipInvoiceFailed,
            ),
          );
        }

        return Stack(
          children: <Widget>[
            SizedBox(
              height: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TitleAndHeaderWidget(
                      title: S(context).tip_order_summary,
                    ),
                    Container(
                      color: ColorsConstant.cWhite,
                      padding: EdgeInsets.symmetric(
                        vertical: 16.w,
                        horizontal: 24.w,
                      ),
                      child: TitleAndValueWidget(
                        title: S(context).tip_value,
                        value: state.tipPaymentInvoice!.booking!.tipAmount
                            .toString(),
                      ),
                    ),
                    _buildDivider(),
                    Container(
                      color: ColorsConstant.cWhite,
                      padding: EdgeInsets.symmetric(
                        vertical: 16.w,
                        horizontal: 24.w,
                      ),
                      child: TitleAndValueWidget(
                        title: S(context).tip_total,
                        value: state.tipPaymentInvoice!.booking!.tipAmount
                            .toString(),
                      ),
                    ),
                    _buildPaymentMethod(),
                  ],
                ),
              ),
            ),
            _nextBtn(),
          ],
        );
      },
    );
  }

  Widget _nextBtn() {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        color: ColorsConstant.cWhite,
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 16.h,
        ),
        child: CustomButton(
          params: CustomButtonParams.primary(
            text: S(context).pay,
            onPressed: () {
              if (BlocProvider.of<TipPaymentBloc>(context)
                      .getTipInvoiceId()
                      ?.isNotEmpty ==
                  true) {
                isProcessingTipInvoice.value = true;
                BlocProvider.of<TipPaymentBloc>(context).add(
                  ProcessTipPaymentInvoiceEvent(
                    BlocProvider.of<TipPaymentBloc>(context).getTipInvoiceId()!,
                  ),
                );
              } else {
                showCommonErrorDialog(
                    context: context,
                    message: S(context).error_common_msg,
                    negativeTitle: S(context).confirm,);
              }
            },
          ),
        ),
      ),
    );
  }

  Padding _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: const Divider(
        height: 1,
        color: ColorsConstant.cFFE3E4E8,
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
      builder: (BuildContext context, PaymentMethodState state) {
        return PaymentMethodWidget(
          state: state,
        );
      },
    );
  }

  void _clearTipPaymentState() {
    BlocProvider.of<TipPaymentBloc>(context).add(ClearStateEvent());
  }

  Widget _retryButton({required Function()? onTap}) {
    return CustomButton(
      params: CustomButtonParams.primary(
        onPressed: () => onTap?.call(),
        wrapWidth: true,
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 8.w),
        text: S(context).try_again,
      ).copyWith(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(
              3,
              3,
            ),
          ),
        ],
      ),
    );
  }

  _loadPaymentInfo() {
    BlocProvider.of<PaymentMethodBloc>(context)
      ..add(
        GetInfoPaymentEvent(getIt<UserRepo>().getCurrentUser().id),
      )
      ..add(
        GetAllPaymentTypeEvent(),
      );
  }

  _upsertTipInvoice({
    String? paymentMethodId,
    String? bookingId,
  }) {
    BlocProvider.of<TipPaymentBloc>(context).add(
      UpsertTipPaymentInvoiceEvent(
        TipPaymentInvoiceRequest(
          paymentMethodId: paymentMethodId,
          bookingId: bookingId,
        ),
      ),
    );
  }
}
