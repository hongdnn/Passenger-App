import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/favorite_location/data/model/favorite_location.dart';
import 'package:passenger/features/favorite_location/presentation/favorite_location_picker_page.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
import 'package:passenger/features/landing_page/presentation/bloc/landing_page_bloc.dart';
import 'package:passenger/features/landing_page/presentation/widget/banner_slider_content.dart';
import 'package:passenger/features/landing_page/presentation/widget/draft_booking_widget.dart';
import 'package:passenger/features/landing_page/presentation/widget/last_booking_content.dart';
import 'package:passenger/features/location/presentation/bloc/search_bloc.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';
import 'package:passenger/util/widgets/bookmark_widget.dart';
import 'package:passenger/util/widgets/search_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:passenger/util/enum.dart';
import 'package:passenger/features/booking_page/presentation/widget/booking_options_widget.dart';

class LandingPageContent extends StatefulWidget {
  const LandingPageContent({Key? key}) : super(key: key);

  @override
  State<LandingPageContent> createState() => _LandingPageContentState();
}

class _LandingPageContentState extends State<LandingPageContent> {

  late List<BookingData> listBookingData;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const ValueKey<String>('landing-page-single-scroll'),
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        key: const ValueKey<String>('landing-page-column'),
        children: <Widget>[
          SizedBox(height: 8.h),
          BookingOptionsWidget(
            onOptionChanged: (int index) {
              getIt<SharedPreferences>().setBool('isBookingNow', index == 0);
            },
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.only(left: 24.w, right: 24.w),
            decoration: BoxDecoration(
              color: ColorsConstant.cWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.w),
                topRight: Radius.circular(20.w),
              ),
            ),
            child: SearchWidget(
              hintText: S(context).hint_text_search,
            ),
          ),
          BlocBuilder<SearchBloc, SearchState>(
            builder: (BuildContext context, SearchState state) {
              List<FavoriteLocation> listLocation = <FavoriteLocation>[];
              listLocation.addAll(
                state.listFavoriteLocation ?? <FavoriteLocation>[],
              );
              listLocation.add(FavoriteLocation());
              return Padding(
                padding: EdgeInsets.only(left: 24.w),
                child: Bookmark(
                  key: const ValueKey<String>(
                    'landing-page-bookmark',
                  ),
                  data: listLocation,
                  onAdd: () {
                    Navigator.pushNamed(
                      context,
                      FavoriteLocationPickerPage.routeName,
                      arguments: FavoriteLocationPickerArg(
                        modifyFavoriteLocation: (FavoriteLocation data) {
                          Future<dynamic>.delayed(
                              const Duration(milliseconds: 500), () {
                            BlocProvider.of<SearchBloc>(context).add(
                              AddFavoriteLocationEvent(
                                favoriteLocation: data,
                              ),
                            );
                          });
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
         const LastBookingContent(),
          SizedBox(
            height: 12.h,
          ),
          const BannerSliderContent(),
          SizedBox(
            height: 24.h,
          ),
          BlocBuilder<LandingPageBloc, LandingPageState>(
            builder: (_, LandingPageState state) {
              listBookingData =
                  state.bookingHistoryModel?.data ?? <BookingData>[];
              if (state.state == LoadState.loading) {
                return Container();
              } else {
                if (listBookingData.isNotEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(left: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          S(context).ready_to_book,
                          style: StylesConstant.ts20w500,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        SizedBox(
                          height: 250.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: listBookingData.length,
                            itemBuilder: (_, int index) {
                              return DraftBookingWidget(
                                data: listBookingData[index],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              }
            },
          ),
          SizedBox(
            height: 30.h,
          )
        ],
      ),
    );
  }
}
