import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/data/model/booking_order_model.dart';
import 'package:passenger/features/booking_page/data/model/upsert_draft_booking_model.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
import 'package:passenger/features/order_history/presentation/widget/list_trip_history_widget.dart';
import 'package:passenger/features/order_history/presentation/widget/order_history_option.dart';
import 'package:passenger/features/tracking_page/data/model/driver_accept_booking_model.dart';
import 'package:passenger/features/tracking_page/tracking_page.dart';
import 'package:passenger/features/trip_detail/trip_detail_page.dart';
import 'package:passenger/main.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';

class OrderHistoryPageArgs {
  OrderHistoryPageArgs({this.reload = false, this.currentTabIndex});
  bool reload;
  OrderHistoryTabIndex? currentTabIndex;
}

class OrderHistoryPageOutputArgs {
  OrderHistoryPageOutputArgs({
    this.reload = false,
  });
  bool reload;
}

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({
    Key? key,
    this.args,
  }) : super(key: key);
  static const String routeName = '/orderHistoryPage';
  final OrderHistoryPageArgs? args;
  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  late final ValueNotifier<int> _currentStatus = ValueNotifier<int>(
    widget.args?.currentTabIndex?.value ?? OrderHistoryTabIndex.ongoing.value,
  );

  late final PageController _pageController;

  final GlobalKey onGoingTab = GlobalKey();
  final GlobalKey completedTab = GlobalKey();
  final GlobalKey canceledTab = GlobalKey();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentStatus.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.popUntil(
                context,
                (Route<dynamic> route) =>
                    route.settings.name == MyHomePage.routeName,
              );
            },
            child: Container(
              alignment: Alignment.centerRight,
              child: SvgPicture.asset(
                SvgAssets.icBackIos,
                height: 18.h,
                width: 10.h,
              ),
            ),
          ),
        ),
        titleSpacing: 16.w,
        leadingWidth: 40.w,
        centerTitle: true,
        title: Text(
          S(context).activities,
          style: StylesConstant.ts18w500,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ValueListenableBuilder<int>(
                valueListenable: _currentStatus,
                builder: (_, int newValue, Widget? widget) {
                  return OrderHistoryOption(
                    onOptionChanged: (int index) {
                      _currentStatus.value = index;
                      _pageController.animateToPage(
                        _currentStatus.value,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    onSelectedButton: _currentStatus.value,
                  );
                },
              ),
              SizedBox(
                height: 8.h,
              ),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: <Widget>[
                    ListTripHistory(
                      key: onGoingTab,
                      tripStatus: TripStatus.ongoing.value,
                      onTapItem: onTapItem,
                    ),
                    ListTripHistory(
                      key: completedTab,
                      tripStatus: TripStatus.completed.value,
                      onTapItem: onTapItem,
                    ),
                    ListTripHistory(
                      key: canceledTab,
                      tripStatus: TripStatus.canceled.value,
                      onTapItem: onTapItem,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onTapItem(BookingData? bookingData, int tripStatus) {
    if (bookingData?.invoice?.id?.isNotEmpty == true &&
        (tripStatus == TripStatus.completed.value ||
            tripStatus == TripStatus.ongoing.value)) {
      Navigator.pushNamed(
        context,
        TripDetailPage.routeName,
        arguments: TripDetailPageArgs(
          id: bookingData?.invoice?.id,
        ),
      ).then((_) {
        final OrderHistoryPageArgs arguments =
            ModalRoute.of(context)?.settings.arguments as OrderHistoryPageArgs;
        if (arguments.reload == true) {
          if (onGoingTab.currentState != null) {
            (onGoingTab.currentState as ListTripHistoryState).onPullToRefresh();
          }
          if (completedTab.currentState != null) {
            (completedTab.currentState as ListTripHistoryState)
                .onPullToRefresh();
          }
          if (canceledTab.currentState != null) {
            (canceledTab.currentState as ListTripHistoryState)
                .onPullToRefresh();
          }
        }
      });
    } else if (tripStatus == TripStatus.ongoing.value &&
        bookingData?.invoice?.id == null) {
      Navigator.pushNamed(
        context,
        TrackingPage.routeName,
        arguments: TrackingArgs(
          isDriverFound: bookingData?.driverInfo?.id != null,
          isLandingPageNavTo: true,
          listLocationRequest: List<LocationRequest>.generate(
            bookingData!.trip!.locations!.length,
            (int index) => LocationRequest(
              longitude: bookingData.trip!.locations?[index].longitude,
              latitude: bookingData.trip!.locations?[index].latitude,
              address: bookingData.trip!.locations?[index].address,
              googleId: bookingData.trip!.locations?[index].googleId,
              referenceId: bookingData.trip!.locations?[index].referenceId,
              addressName: bookingData.trip!.locations?[index].addressName,
              note: bookingData.trip!.locations?[index].note.toString(),
            ),
          ),
          distance: bookingData.trip?.distance,
          timeEst: bookingData.trip?.totalTime?.toDouble(),
          bookingOrderModel: BookingOrderModel(
            data: BookingData(
              id: bookingData.id,
              userId: bookingData.userId,
            ),
          ),
          driverAcceptBookingModel: DriverAcceptBookingModel(
            data: bookingData,
          ),
          isBookingNow: bookingData.trip?.isTripLater == false,
          price: bookingData.price,
          bookingId: bookingData.id,
        ),
      );
    }
  }
}
