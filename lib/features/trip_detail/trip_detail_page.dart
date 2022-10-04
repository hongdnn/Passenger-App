import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/data/model/invoice_model.dart';
import 'package:passenger/features/booking_page/data/model/upsert_draft_booking_model.dart';
import 'package:passenger/features/booking_page/presentation/booking_page.dart';
import 'package:passenger/features/driver_rating/presentation/driver_rating_page.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
import 'package:passenger/features/order_history/presentation/order_history_page.dart';
import 'package:passenger/features/payment/presentation/payment_page.dart';
import 'package:passenger/features/trip_detail/presentation/bloc/invoice_bloc.dart';
import 'package:passenger/features/trip_detail/presentation/bloc/util/extension.dart';
import 'package:passenger/features/trip_detail/presentation/widget/booking_info_widget.dart';
import 'package:passenger/features/trip_detail/presentation/widget/destination_indicator.dart';
import 'package:passenger/features/trip_detail/presentation/widget/direction_info_widget.dart';
import 'package:passenger/features/trip_detail/presentation/widget/divider_widget.dart';
import 'package:passenger/features/trip_detail/presentation/widget/driver_info_widget.dart';
import 'package:passenger/features/trip_detail/presentation/widget/payment_method_widget.dart';
import 'package:passenger/features/trip_detail/presentation/widget/title_and_value_widget.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/string_constant.dart';
import 'package:passenger/util/styles.dart';
import 'package:passenger/util/util.dart';
import 'package:passenger/util/widgets/custom_button.dart';
import 'package:passenger/util/widgets/custom_dialog.dart';
import 'package:passenger/util/widgets/error_empty_result_widget.dart';

class TripDetailPageArgs {
  TripDetailPageArgs({
    this.id,
  });
  String? id;
}

class TripDetailPageOutputArgs {
  TripDetailPageOutputArgs({
    this.reload = false,
  });
  bool reload;
}

class TripDetailPage extends StatefulWidget {
  const TripDetailPage({Key? key, required this.args}) : super(key: key);
  final TripDetailPageArgs args;

  @override
  State<TripDetailPage> createState() => _TripDetailPageState();

  static const String routeName = '/tripDetailPage';
}

class _TripDetailPageState extends State<TripDetailPage> {
  final InvoiceBloc _invoiceBloc = getIt();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InvoiceBloc>(
      create: (BuildContext context) =>
          _invoiceBloc..add(GetInvoiceDetailEvent(invoiceId: widget.args.id!)),
      child: BlocBuilder<InvoiceBloc, InvoiceState>(
        buildWhen: (InvoiceState previous, InvoiceState current) {
          return previous.loadDetailInvoiceState !=
              current.loadDetailInvoiceState;
        },
        builder: (BuildContext context, InvoiceState invoiceState) {
          return Scaffold(
            backgroundColor: ColorsConstant.cFFF7F7F8,
            appBar: _buildAppBar(
              context: context,
              invoiceState: invoiceState,
            ),
            body: _buildMainContent(invoiceState),
          );
        },
      ),
    );
  }

  Widget _buildMainContent(InvoiceState state) {
    if (state.loadDetailInvoiceState == LoadState.loading ||
        state.loadDetailInvoiceState == LoadState.none) {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    } else if (state.loadDetailInvoiceState == LoadState.failure) {
      return Center(
        child: ErrorOrEmptyResultWidget(
          errorMessage: S(context).losing_connect,
          actions: CustomButton(
            params: CustomButtonParams.primary(
              onPressed: retryLoadInvoice,
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
          ),
        ),
      );
    }
    if (state.currentInvoiceDetail == null) {
      return const SizedBox();
    }
    InvoiceData invoice = state.currentInvoiceDetail!;

    if (invoice.booking == null) {
      return const SizedBox();
    }
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildPaymentStatus(invoice),
          (invoice.booking!.trip?.locations?.isNotEmpty ?? false)
              ? DestinationIndicator(
                  finishLocations: invoice.booking!.trip!.locations!,
                  isDisplayArrivedTime:
                      invoice.invoiceStatus == InvoiceStatus.completed.value,
                )
              : const SizedBox(),
          const DividerWidget(),
          DirectionInfoWidget(
            invoice: invoice,
          ),
          invoice.invoiceStatus == InvoiceStatus.completed.value
              ? _buildDriverInfo(invoice)
              : const SizedBox.shrink(),
          const DividerWidget(),
          _buildStarRating(invoice),
          _buildAdvancedBookingTime(invoice),
          _buildBookingInfo(invoice),
          _buildPaymentMethod(invoice),
          _buildBottomButton(invoice),
        ],
      ),
    );
  }

  AppBar _buildAppBar({
    required BuildContext context,
    required InvoiceState invoiceState,
  }) {
    return AppBar(
      leading: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          Navigator.of(context).popUntil((Route<dynamic> route) {
            if (route.settings.name == OrderHistoryPage.routeName) {
              (route.settings.arguments as OrderHistoryPageArgs).reload =
                  invoiceState.processInvoiceStatus == LoadState.success;
              return true;
            } else {
              return false;
            }
          });
        },
        icon: SvgPicture.asset(SvgAssets.icBackIos),
      ),
      title: Text(
        invoiceState.currentInvoiceDetail != null &&
                invoiceState.currentInvoiceDetail?.paymentDate != null
            ? formatDateThailand(
                invoiceState.currentInvoiceDetail!.paymentDate.validValue(),
              )
            : '',
        style: StylesConstant.ts18w500,
      ),
      centerTitle: false,
    );
  }

  Widget _buildPaymentStatus(InvoiceData invoice) {
    if (invoice.invoiceStatus == InvoiceStatus.completed.value) {
      return _buildSuccessfulPaymentStatus(invoice);
    }
    if (invoice.invoiceStatus == InvoiceStatus.failed.value) {
      return _buildFailedPaymentStatus(invoice);
    }

    if (invoice.booking?.status == BookingStatus.completed.value &&
        invoice.invoiceStatus == InvoiceStatus.processing.value) {
      return _buildProcesssingPaymentStatus(invoice);
    }

    return _buildInvoiceNumber(invoice);
  }

  Widget _buildSuccessfulPaymentStatus(InvoiceData invoice) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.w),
          color: ColorsConstant.cFF6FCF97,
          child: Row(
            children: <Widget>[
              SvgPicture.asset(SvgAssets.icSuccess),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Text(
                  S(context).successful_payment,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: StylesConstant.ts16w400
                      .copyWith(color: ColorsConstant.cWhite),
                ),
              )
            ],
          ),
        ),
        _buildInvoiceNumber(invoice)
      ],
    );
  }

  Widget _buildFailedPaymentStatus(InvoiceData invoice) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.w),
      color: ColorsConstant.cFFEB6666,
      child: Row(
        children: <Widget>[
          SvgPicture.asset(SvgAssets.icError),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              S(context).error_msg_payment,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: StylesConstant.ts16w400
                  .copyWith(color: ColorsConstant.cWhite),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProcesssingPaymentStatus(InvoiceData invoice) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.w),
          color: ColorsConstant.cFFF6E5F6,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      S(context).waiting_for_payment,
                      style: StylesConstant.ts16w500.copyWith(
                        color: ColorsConstant.cFFA33AA3,
                      ),
                    ),
                    Text(
                      S(context).complete_within_48_hours,
                      style: StylesConstant.ts12w400.copyWith(
                        color: ColorsConstant.cFFA33AA3,
                      ),
                    )
                  ],
                ),
              ),
              CustomButton(
                params: CustomButtonParams.primary(
                  onPressed: () {
                    _onPayForWaitingPayment(invoice);
                  },
                  text: S(context).pay,
                  backgroundColor: ColorsConstant.cFFA33AA3,
                  padding:
                      EdgeInsets.symmetric(vertical: 8.w, horizontal: 38.w),
                ),
              )
            ],
          ),
        ),
        _buildInvoiceNumber(invoice),
      ],
    );
  }

  Widget _buildInvoiceNumber(InvoiceData invoice) {
    return Container(
      color: ColorsConstant.cFFF7F7F8,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.w),
      child: Row(
        children: <Widget>[
          SvgPicture.asset(SvgAssets.icOrderNo),
          SizedBox(width: 16.w),
          Text(
            '${S(context).order_no} ${invoice.booking?.orderId.validValue()}',
            style: StylesConstant.ts14w400,
          )
        ],
      ),
    );
  }

  Widget _buildDriverInfo(InvoiceData invoice) {
    BookingData booking = invoice.booking!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTitleHeader(
          title: S(context).driver,
          subtitle:
              booking.ratingDriver == null ? S(context).rate_service : null,
          onTapSubtitle: () {
            if (invoice.booking?.id != null) {
              Navigator.pushNamed(
                context,
                DriverRatingPage.routeName,
                arguments: DriverRatingPageArgs(
                  isPopBack: true,
                  bookingId: invoice.booking!.id!,
                ),
              ).then((_) {
                final TripDetailPageOutputArgs arguments =
                    ModalRoute.of(context)?.settings.arguments
                        as TripDetailPageOutputArgs;
                if (arguments.reload == true) {
                  _refreshTripDetail(invoiceId: widget.args.id!);
                }
              });
            } else {
              showCommonErrorDialog(
                context: context,
                message: S(context).error_common_msg,
                negativeTitle: S(context).confirm,
              );
            }
          },
        ),
        DriverInfoWidget(
          invoice: invoice,
        ),
      ],
    );
  }

  _refreshTripDetail({required String invoiceId}) {
    _invoiceBloc.add(GetInvoiceDetailEvent(invoiceId: invoiceId));
  }

  Widget _buildStarRating(InvoiceData invoice) {
    return invoice.booking?.ratingDriver?.ratingStar != null
        ? Container(
            color: ColorsConstant.cWhite,
            padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  S(context).rate_service,
                  style: StylesConstant.ts16w400,
                ),
                Row(
                  children: <Widget>[
                    Text('${invoice.booking?.ratingDriver?.ratingStar ?? ''}'),
                    SizedBox(width: 5.w),
                    SvgPicture.asset(
                      SvgAssets.icStarSelected,
                      width: 13.w,
                      height: 13.w,
                    )
                  ],
                )
              ],
            ),
          )
        : const SizedBox();
  }

  Widget _buildAdvancedBookingTime(InvoiceData invoice) {
    if (invoice.booking?.trip?.isTripLater == false) {
      return const SizedBox();
    }
    return Column(
      children: <Widget>[
        _buildTitleHeader(
          title: S(context).schedule_a_ride_for_header,
          subtitle: '',
        ),
        Container(
          color: ColorsConstant.cWhite,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.w),
          child: TitleAndValueWidget(
            title: S(context).schedule_a_ride_for_title,
            value: invoice.booking?.trip?.startTime != null
                ? buildDateInLocale(
                    inputString: invoice.booking!.trip!.startTime!,
                    context: context,
                  )
                : '',
          ),
        )
      ],
    );
  }

  Widget _buildBookingInfo(InvoiceData invoice) {
    BookingData booking = invoice.booking!;
    return Column(
      children: <Widget>[
        _buildTitleHeader(
          title: S(context).summary,
          subtitle: S(context).ride_again,
          onTapSubtitle: () {
            _onNavigateToBooking(invoice);
          },
          invoice: invoice,
        ),
        BookingInfoWidget(
          invoice: invoice,
          booking: booking,
        )
      ],
    );
  }

  void _onNavigateToBooking(InvoiceData invoice) {
    Navigator.pushNamed(
      context,
      BookingPage.routeName,
      arguments: BookingArg(
        bookingLocationList: null,
        reorderBookingData: invoice.booking,
      ),
    );
  }

  Widget _buildPaymentMethod(InvoiceData invoice) {
    return Column(
      children: <Widget>[
        _buildTitleHeader(
          title: S(context).payment_methods_trip_detail,
          subtitle: invoice.invoiceStatus != InvoiceStatus.completed.value
              ? S(context).select_payment_method_trip_detail
              : '',
        ),
        PaymentMethodTripDetailWidget(
          moneyType: S(context).fare,
          amount: invoice.amount,
          iconPaymentType: invoice.booking?.paymentMethod?.paymentType?.icon,
          paymentMethodName: invoice.booking?.paymentMethod?.name,
          paymentTypeName:
              invoice.booking?.tipInvoice?.paymentMethod?.paymentType?.name,
          isCard: invoice.booking?.paymentMethod?.paymentType?.isCard,
          cardLastDigits: invoice.booking?.paymentMethod?.cardLastDigits,
        ),
        const DividerWidget(),
        invoice.booking?.tipInvoice != null
            ? PaymentMethodTripDetailWidget(
                moneyType: S(context).tip,
                amount: invoice.booking?.tipAmount ?? 0,
                iconPaymentType: invoice
                    .booking?.tipInvoice?.paymentMethod?.paymentType?.icon,
                paymentMethodName:
                    invoice.booking?.tipInvoice?.paymentMethod?.name,
                paymentTypeName: invoice
                    .booking?.tipInvoice?.paymentMethod?.paymentType?.name,
                isCard: invoice
                    .booking?.tipInvoice?.paymentMethod?.paymentType?.isCard,
                cardLastDigits:
                    invoice.booking?.tipInvoice?.paymentMethod?.cardLastDigits,
              )
            : const SizedBox(),
      ],
    );
  }

  Widget _buildBottomButton(InvoiceData invoice) {
    return invoice.invoiceStatus == InvoiceStatus.completed.value ||
            invoice.invoiceStatus == InvoiceStatus.processing.value
        ? _buildReportIssueButton(invoice)
        : _buildPayButton(invoice);
  }

  Widget _buildReportIssueButton(InvoiceData invoice) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 110.w)
          .copyWith(top: 40.w, bottom: 34.w),
      child: CustomButton(
        params: CustomButtonParams.primary(
          wrapWidth: true,
          text: S(context).report_issue,
          onPressed: () {
            urlSchemaUtil(StringConstant.reportIssueLink, UrlSchemaType.link);
          },
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
      ),
    );
  }

  Widget _buildPayButton(InvoiceData invoice) {
    return Container(
      color: ColorsConstant.cWhite,
      margin: EdgeInsets.only(top: 90.w),
      padding: EdgeInsets.symmetric(horizontal: 24.w)
          .copyWith(top: 16.w, bottom: 32.w),
      child: CustomButton(
        params: CustomButtonParams.primary(
          onPressed: () {
            if (invoice.invoiceStatus != InvoiceStatus.completed.value) {
              _onPayAgain(invoice.id);
            }
          },
          text: S(context).pay,
        ),
      ),
    );
  }

  void _onPayForWaitingPayment(InvoiceData invoice) {
    Navigator.pushNamed(
      context,
      PaymentPage.routeName,
      arguments: PaymentArg(
        listLocation: List<LocationRequest>.generate(
          (invoice.booking?.trip?.locations ?? <TripLocation>[]).length,
          (int index) => LocationRequest.fromTripLocation(
            invoice.booking!.trip!.locations![index],
          ),
        ),
        bookingId: invoice.booking?.id,
      ),
    );
  }

  void _onPayAgain(String? invoiceId) {
    if (invoiceId == null) return;
    _invoiceBloc.add(
      ProcessAndGetInvoiceEvent(
        invoiceId: invoiceId,
      ),
    );
  }

  Widget _buildTitleHeader({
    required String title,
    String? subtitle,
    Function()? onTapSubtitle,
    InvoiceData? invoice,
  }) {
    return Container(
      padding: EdgeInsets.only(bottom: 8.w, top: 24.w, left: 24.w, right: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: StylesConstant.ts16w500,
          ),
          subtitle != null
              ? InkWell(
                  onTap: () {
                    onTapSubtitle?.call();
                  },
                  child: Text(
                    subtitle,
                    style: StylesConstant.ts14w500.copyWith(
                      color: ColorsConstant.cFFA33AA3,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  retryLoadInvoice() {
    _invoiceBloc.add(
      GetInvoiceDetailEvent(
        invoiceId: widget.args.id!,
      ),
    );
  }
}
