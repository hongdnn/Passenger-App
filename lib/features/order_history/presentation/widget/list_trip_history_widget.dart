import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
import 'package:passenger/features/order_history/presentation/bloc/order_history_bloc.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/string_constant.dart';
import 'package:passenger/util/styles.dart';

class ListTripHistory extends StatefulWidget {
  const ListTripHistory({
    Key? key,
    this.onTapItem,
    required this.tripStatus,
  }) : super(key: key);
  final int tripStatus;
  final Function(BookingData? invoiceId, int tripStatus)? onTapItem;

  @override
  State<ListTripHistory> createState() => ListTripHistoryState();
}

class ListTripHistoryState extends State<ListTripHistory>
    with AutomaticKeepAliveClientMixin {
  final OrderHistoryBloc _orderHistoryBloc = getIt();
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<OrderHistoryBloc>(
      create: (BuildContext context) => _orderHistoryBloc
        ..add(GetBookingHistoryInitEvent(status: widget.tripStatus)),
      child: RefreshIndicator(
        onRefresh: onPullToRefresh,
        child: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
          builder: (BuildContext context, OrderHistoryState orderHistoryState) {
            final List<BookingData>? dataBooking =
                orderHistoryState.dataBooking;
            if (orderHistoryState.historyBookingState == LoadState.loading) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (dataBooking?.isEmpty == true) {
              return Container(
                padding: EdgeInsets.only(top: 68.h),
                alignment: Alignment.topCenter,
                child: Text(
                  _buildEmptyDataText(),
                  textAlign: TextAlign.center,
                  style: StylesConstant.ts14w400cFFABADBA
                      .copyWith(color: ColorsConstant.cFF73768C),
                ),
              );
            } else {
              return _buildTripInformation(
                orderHistoryState,
                dataBooking,
                context,
                widget.tripStatus,
              );
            }
          },
        ),
      ),
    );
  }

  String _buildEmptyDataText() {
    if (widget.tripStatus == TripStatus.ongoing.value) {
      return S(context).you_do_not_have_any_ongoing_activities;
    } else if (widget.tripStatus == TripStatus.completed.value) {
      return S(context).you_do_not_have_any_completed_activities;
    } else {
      return S(context).you_do_not_have_any_canceled_activities;
    }
  }

  Widget _buildTripInformation(
    OrderHistoryState orderHistoryState,
    List<BookingData>? dataBooking,
    BuildContext context,
    int tripStatus,
  ) {
    return NotificationListener<ScrollNotification>(
      onNotification: !orderHistoryState.isLastPage
          ? _loadMore
          : (ScrollNotification notification) {
              return false;
            },
      child: ListView(
        physics: const ClampingScrollPhysics(),
        controller: _controller,
        children: List<Widget>.generate(dataBooking?.length ?? 0, (int index) {
          final Trip? trip = dataBooking?[index].trip;
          final int? bookingStatus = dataBooking?[index].status;

          final int? invoiceStatus = dataBooking?[index].invoice?.invoiceStatus;

          final String updateTime = dataBooking?[index].updatedAt ?? '';
          return InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () async {
              if (tripStatus != TripStatus.canceled.value) {
                widget.onTapItem?.call(dataBooking![index], widget.tripStatus);
              }
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h)
                      .copyWith(right: 24.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SvgPicture.asset(SvgAssets.icCarFrame),
                      SizedBox(
                        width: 16.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      right: 24.w,
                                    ),
                                    child: Text(
                                      trip?.locations?.last.address ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      style: StylesConstant.ts14w500.copyWith(
                                        color: _getTripInformationNameTextColor(
                                          bookingStatus,
                                          invoiceStatus,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  removeDecimalZeroFormat(
                                    dataBooking?[index].price ?? 0,
                                  ),
                                  style: StylesConstant.ts14w500.copyWith(
                                    color: ColorsConstant.cFF73768C,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              _getTripDateAndType(updateTime, trip, context),
                              style: StylesConstant.ts14w400.copyWith(
                                color: ColorsConstant.cFF73768C,
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              _buildInvoiceStatusText(
                                invoiceStatus: invoiceStatus,
                                tripStatus: tripStatus,
                                bookingStatus: bookingStatus ??
                                    BookingStatus.canceled.value,
                              ),
                              style: StylesConstant.ts14w400.copyWith(
                                color: _getTripInformationTextColor(
                                  bookingStatus,
                                  invoiceStatus,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  endIndent: 24.h,
                  color: ColorsConstant.cFFE3E4E8,
                  height: 1,
                ),
                _buildLazyLoading(
                  index,
                  dataBooking?.length,
                  orderHistoryState.isLazyLoading ?? false,
                  orderHistoryState.isLastPage,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  String _getTripDateAndType(
    String updateTime,
    Trip? trip,
    BuildContext context,
  ) =>
      '''${buildDateInLocale(
        inputString: updateTime,
        context: context,
      )} • ${_buildTripType(trip, context)}''';

  Color _getTripInformationTextColor(
    int? bookingStatus,
    int? invoiceStatus,
  ) {
    return isFailedPayment(
      bookingStatus,
      invoiceStatus,
    )
        ? ColorsConstant.cFFFF453A
        : ColorsConstant.cFFA33AA3;
  }

  Color _getTripInformationNameTextColor(
    int? bookingStatus,
    int? invoiceStatus,
  ) {
    return isFailedPayment(
      bookingStatus,
      invoiceStatus,
    )
        ? ColorsConstant.cFFFF453A
        : ColorsConstant.cFF454754;
  }

  bool isFailedPayment(
    int? bookingStatus,
    int? invoiceStatus,
  ) {
    return (bookingStatus == BookingStatus.completed.value &&
        invoiceStatus == InvoiceStatus.failed.value);
  }

  String _buildTripType(Trip? trip, BuildContext context) =>
      trip?.isTripLater == true
          ? S(context).book_in_advance
          : S(context).book_trip_now;

  bool _loadMore(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (_controller.position.extentAfter > -0.8) {
        _onLoading();
      }
    }
    return false;
  }

  String _buildInvoiceStatusText({
    int? invoiceStatus,
    required int tripStatus,
    required int bookingStatus,
  }) {
    if (tripStatus == TripStatus.canceled.value) {
      return S(context).canceled_drive;
    } else if (tripStatus == TripStatus.completed.value) {
      return S(context).successful;
    } else {
      // tripStatus == TripStatus.ongoing.value
      if (bookingStatus == BookingStatus.canceled.value) {
        return S(context).canceled_drive;
      } else if (bookingStatus == BookingStatus.confirmed.value) {
        return S(context).confirm;
      } else if (bookingStatus == BookingStatus.searching.value) {
        return S(context).search;
      } else if (bookingStatus == BookingStatus.driverFound.value) {
        return S(context).driver_found;
      } else if (bookingStatus == BookingStatus.driverWillArriveIn1Hour.value) {
        return S(context).driver_will_arrived_within_1_hours;
      } else if (bookingStatus == BookingStatus.driverAlmostArrive.value) {
        return S(context).the_driver_is_almost_there;
      } else if (bookingStatus == BookingStatus.waiting.value) {
        return S(context).the_driver_is_waiting;
      } else if (bookingStatus == BookingStatus.driverArrive.value) {
        return S(context).the_driver_is_here;
      } else if (bookingStatus == BookingStatus.driverPickUp.value) {
        return S(context).driver_pickup;
      }
      // For  bookingStatus ={canceled, confirmed, searching, driverFound,
      // driverWillArriveIn1Hour,driverAlmostArrive,waiting,driverArrive,
      // driverPickUp} -> Redirect to Tracking Page at bookingId
      else if (bookingStatus == BookingStatus.completed.value) {
        //Check the invoiceStatus
        if (invoiceStatus == InvoiceStatus.failed.value) {
          //Fail payment
          return S(context).unsuccessful_payment;
        } else if (invoiceStatus == InvoiceStatus.processing.value) {
          // Trip is complete but the bill is still not payed
          return S(context).waiting_for_payment;
        } else if (invoiceStatus == InvoiceStatus.completed.value) {
          //The bill have been payed and the trip is completed
          return S(context).completed;
        } else {
          // The driver has reach the destination
          // but the bill have not been made
          return S(context).driver_arrived_destination;
        }
      } else if (bookingStatus == BookingStatus.processing.value) {
        // The bookingStatus is processing
        // and there's does or doesn't have invoice
        return S(context).waiting_for_payment;
      } else {
        return S(context).drop_off_mid_destination;
      }
    }
  }

  Widget _buildLazyLoadingStatus(
    bool isLazyLoading,
    bool isLastPage,
  ) {
    if (isLazyLoading && isLastPage == false) {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Future<void> onPullToRefresh() async {
    await Future<void>.delayed(const Duration(milliseconds: 1000));
    _orderHistoryBloc.add(
      GetBookingHistoryInitEvent(status: widget.tripStatus),
    );
  }

  void _onLoading() {
    _orderHistoryBloc.add(
      GetNextPageListBookingEvent(),
    );
    _orderHistoryBloc.add(
      GetBookingHistoryEvent(
        status: widget.tripStatus,
        isLazyLoading: true,
      ),
    );
  }

  Widget _buildLazyLoading(
    int index,
    int? length,
    bool isLazyLoading,
    bool isLastPage,
  ) {
    if (index == length! - 1) {
      return _buildLazyLoadingStatus(
        isLazyLoading,
        isLastPage,
      );
    }
    return const SizedBox.shrink();
  }

  @override
  bool get wantKeepAlive => true;
}
