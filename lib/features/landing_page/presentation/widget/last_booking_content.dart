import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/landing_page/data/model/booking_history_sort_by_time_model.dart';
import 'package:passenger/features/landing_page/presentation/bloc/landing_page_bloc.dart';
import 'package:passenger/features/landing_page/presentation/widget/last_booking_widget.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/widgets/custom_card_widget.dart';

class LastBookingContent extends StatelessWidget {
  const LastBookingContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandingPageBloc, LandingPageState>(
      builder: (BuildContext context, LandingPageState state) {
        if (state.state == LoadState.loading) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (state.bookingHistorySortByTimeModel?.data != null &&
            state.bookingHistorySortByTimeModel!.data!.isNotEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: CustomCardWidget<BookingDataSortByTime>(
              key: const ValueKey<String>(
                'landing-page-custom-card',
              ),
              margin: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              title: S(context).recently_used,
              data: state.bookingHistorySortByTimeModel?.data ??
                  <BookingDataSortByTime>[],
              itemBuilder: (
                BuildContext context,
                BookingDataSortByTime item,
                _,
              ) =>
                  LastBookingWidget(
                key: const ValueKey<String>(
                  'landing-page-last-booking',
                ),
                data: item,
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
