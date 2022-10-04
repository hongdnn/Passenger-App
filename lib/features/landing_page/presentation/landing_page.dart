import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:passenger/core/util/localization.dart';
import 'package:passenger/core/util/route_observer.dart';
import 'package:passenger/features/landing_page/presentation/bloc/landing_page_bloc.dart';
import 'package:passenger/features/landing_page/presentation/widget/landing_page_content.dart';
import 'package:passenger/features/landing_page/presentation/widget/landing_page_track_status.dart';
import 'package:passenger/features/location/presentation/bloc/search_bloc.dart';
import 'package:passenger/features/map_page/presentation/map_page.dart';
import 'package:passenger/features/order_history/presentation/order_history_page.dart';
import 'package:passenger/features/tracking_page/data/model/driver_accept_booking_model.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/widgets/custom_floating_button.dart';
import 'package:passenger/util/widgets/screen_collapse_appbar.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);
  static const String routeName = '/landingPage';

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin, RouteAware {
  final ValueNotifier<bool> showFillColor = ValueNotifier<bool>(false);
  late AnimationController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appRouteObserver.subscribe(
      this,
      ModalRoute.of(context) as PageRoute<dynamic>,
    );
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    BlocProvider.of<SearchBloc>(context)
      ..add(GetCurrentLocationEvent())
      ..add(GetFavoriteLocationsEvent());
  }

  @override
  void didPopNext() {
    super.didPopNext();
    // TODO: currently always reload data when backed to this page
    // Optimize later
    SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
      refresh();
      BlocProvider.of<LandingPageBloc>(context)
          .add(CheckBookingAvailabilityEvent());
    });
  }

  void refresh() {
    BlocProvider.of<LandingPageBloc>(context).add(RefreshAllDataEvent());
    BlocProvider.of<SearchBloc>(context).add(GetFavoriteLocationsEvent());
  }

  @override
  void dispose() {
    appRouteObserver.unsubscribe(this);
    _controller.dispose();
    super.dispose();
  }

  late DriverAcceptBookingModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const ValueKey<String>('landing-page-scaffold'),
      body: BlocBuilder<LandingPageBloc, LandingPageState>(
        builder: (_, LandingPageState state) {
          return Stack(
            key: const ValueKey<String>('landing-page-stack'),
            children: <Widget>[
              ScreenCollapseAppbar(
                key: const ValueKey<String>('landing-page-collapse-appbar'),
                hasTrailingIcon: false,
                flexibleBackground: const MapPage(
                  key: ValueKey<String>('landing-page-mappage'),
                ),
                height: state.bookingHistoryModel?.data == null ||
                        state.bookingHistoryModel!.data!.isEmpty
                    ? 450.h
                    : null,
                isSliverAppBarScrolled: true,
                flexibleTitle: S(context).landing_page_title,
                content: const LandingPageContent(),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: showFillColor,
                builder: (BuildContext _, bool value, Widget? __) {
                  if (value) {
                    return InkWell(
                      onTap: () {
                        showFillColor.value = _controller.isDismissed;
                        _controller.isDismissed
                            ? _controller.forward()
                            : _controller.reverse();
                      },
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: ColorsConstant.c80Black.withOpacity(0.6),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              if (state.checkBookingAvailabilityStatus == LoadState.success &&
                  state.checkBookingAvailabilityModel?.data?.isAvailable !=
                      null &&
                  !state.checkBookingAvailabilityModel!.data!.isAvailable! &&
                  state.bookingStatus != BookingStatus.completed)
                const Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: LandingPageTrackStatus(),
                ),
            ],
          );
        },
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        child: ValueListenableBuilder<bool>(
          valueListenable: showFillColor,
          builder: (_, bool value, __) {
            return CustomFloatingButton(
              key: const ValueKey<String>(
                'landing-page-custom-floating-button',
              ),
              controller: _controller,
              showFillColor: value,
              onTap: () {
                showFillColor.value = _controller.isDismissed;
              },
              onTapHistoryIcon: () {
                Navigator.pushNamed(
                  context,
                  OrderHistoryPage.routeName,
                );
                showFillColor.value = _controller.isDismissed;
              },
            );
          },
        ),
      ),
    );
  }
}
