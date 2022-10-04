import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/landing_page/data/model/booking_history_sort_by_time_model.dart';
import 'package:passenger/features/landing_page/presentation/bloc/landing_page_bloc.dart';
import 'package:passenger/features/location/data/model/place_detail_model.dart';
import 'package:passenger/features/location/data/repo/current_location_repo.dart';
import 'package:passenger/features/favorite_location/presentation/favorite_location_picker_page.dart';
import 'package:passenger/features/location/presentation/widget/search_result_list.dart';
import 'package:passenger/util/widgets/basic_list_tile.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/features/location/data/model/autocomplete_model.dart';
import 'package:passenger/features/favorite_location/data/model/favorite_location.dart';
import 'package:passenger/features/location/data/model/location_address_model.dart';
import 'package:passenger/features/location/presentation/bloc/search_bloc.dart';
import 'package:passenger/features/location/presentation/widget/location_picker_page.dart';
import 'package:passenger/features/location/presentation/widget/location_saved_item.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/widgets/custom_card_widget.dart';
import 'package:passenger/util/widgets/screen_collapse_appbar.dart';
import 'package:passenger/util/widgets/search_appbar_widget.dart';

class SearchPageArgs {
  SearchPageArgs({
    this.locationPickParent = LocationPickParent.landing,
    this.optionSearchResult = OptionSearchResult.booking,
  });

  final LocationPickParent locationPickParent;
  final OptionSearchResult optionSearchResult;
}

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
    required this.args,
  }) : super(key: key);
  final SearchPageArgs args;
  static const String routeName = '/searchPage';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<bool> showFillColor = ValueNotifier<bool>(false);

  late int currentTabIndex;

  late SearchBloc blocSearch;
  late LandingPageBloc landingPageBloc;

  @override
  void initState() {
    super.initState();
    blocSearch = getIt();
    landingPageBloc = getIt();
    currentTabIndex = 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: <BlocProvider<Bloc<dynamic, dynamic>>>[
          BlocProvider<SearchBloc>(
            create: (BuildContext context) => blocSearch
              ..add(GetCurrentLocationEvent())
              ..add(GetFavoriteLocationsEvent()),
          ),
          BlocProvider<LandingPageBloc>(
            create: (BuildContext context) =>
                landingPageBloc..add(GetBookingHistorySortByTimeEvent(3)),
          ),
        ],
        child: Container(
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              ScreenCollapseAppbar(
                hasTrailingIcon: false,
                isSliverAppBarScrolled: false,
                isTapOnIconBack: true,
                title: Padding(
                  padding: EdgeInsets.only(right: 19.w),
                  child: SearchAppbarWidget(
                    onChanged: _onTextChange,
                  ),
                ),
                content: BlocConsumer<SearchBloc, SearchState>(
                  builder: (BuildContext context, SearchState state) {
                    return _buildContent(state);
                  },
                  listener: (BuildContext context, SearchState state) {
                    if (state.getPlaceDetailStatus == LoadState.success) {
                      if (state.placeDetail != null) {
                        if (widget.args.optionSearchResult ==
                            OptionSearchResult.favorite) {
                          Navigator.pop(
                            context,
                            FavoriteLocation(
                              address:
                                  state.placeDetail?.result?.formattedAddress ??
                                      '',
                              latitude: state.placeDetail?.result?.geometry
                                      ?.location?.lat ??
                                  0.0,
                              longitude: state.placeDetail?.result?.geometry
                                      ?.location?.lng ??
                                  0.0,
                              googleId:
                                  state.placeDetail?.result?.placeId ?? '',
                              referenceId:
                                  state.placeDetail?.result?.reference ?? '',
                            ),
                          );
                        } else {
                          // Tap item search
                          Navigator.pushNamed(
                            context,
                            LocationPickerPage.routeName,
                            arguments: LocationPickerArg(
                              locationPickParent:
                                  widget.args.locationPickParent,
                              bookingLocation:
                                  LocationAddressModel.from(state.placeDetail),
                            ),
                          );
                        }
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Center _buildEmptySearch(BuildContext context, SearchState state) {
    return Center(
      child: Text('${S(context).no_data_for} ${state.keyword}'),
    );
  }

  Widget _buildContent(SearchState state) {
    final List<Prediction> predictions =
        state.listAutoComplete?.predictions ?? <Prediction>[];
    if (state.state == LoadState.loading && state.keyword?.isNotEmpty == true) {
      return const Padding(
        padding: EdgeInsets.only(top: 24),
        child: CupertinoActivityIndicator(),
      );
    }
    if (state.state == LoadState.success &&
        state.keyword?.isEmpty == false &&
        predictions.isEmpty) {
      return _buildEmptySearch(context, state);
    }
    if (state.state == LoadState.success && predictions.isNotEmpty) {
      return SearchResultList(
        predictions: predictions,
        onItemTap: (Prediction item) {
          blocSearch.add(GetPlaceDetailEvent(item.placeId ?? ''));
        },
      );
    }
    PlaceDetailModel? placeDetailModel =
        getIt<CurrentLocationRepo>().placeDetailModel;
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _currentLocationBtn(placeDetailModel),
          _chooseFromMapBtn(placeDetailModel),
          _bookingHistory(),
          SizedBox(height: 12.h),
          if (state.favLocationStatus == LoadState.loading)
            const Center(child: CupertinoActivityIndicator())
          else
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: CustomCardWidget<FavoriteLocation>(
                title: S(context).save_place,
                data: state.listFavoriteLocation ?? <FavoriteLocation>[],
                itemCount: state.listFavoriteLocation?.length,
                margin: EdgeInsets.symmetric(horizontal: 0.w),
                itemBuilder: (
                  BuildContext context,
                  FavoriteLocation item,
                  int index,
                ) {
                  return LocationSavedItem(
                    onDelete: _requestDeleteFavoriteLocation,
                    onEdit: (FavoriteLocation data) {
                      _navigateToEditFavoriteLocation(data, state);
                    },
                    data: item,
                    onTap: () {
                      // Tap on favorite location
                      Navigator.pushNamed(
                        context,
                        LocationPickerPage.routeName,
                        arguments: LocationPickerArg(
                          locationPickParent: widget.args.locationPickParent,
                          bookingLocation:
                              LocationAddressModel.fromFavoriteLocation(item),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          _buildAddFavoriteLocationButton(state)
        ],
      ),
    );
  }

  Widget _bookingHistory() {
    return BlocBuilder<LandingPageBloc, LandingPageState>(
      buildWhen: (LandingPageState previous, LandingPageState current) =>
          current.getBookingHistorySortByTimeLoadState !=
          previous.getBookingHistorySortByTimeLoadState,
      builder: (BuildContext context, LandingPageState state) {
        return Column(
          children: <Widget>[
            SizedBox(height: 12.h),
            if (state.getBookingHistorySortByTimeLoadState == LoadState.loading)
              const Center(child: CupertinoActivityIndicator())
            else if (state.bookingHistorySortByTimeModel?.data != null &&
                state.bookingHistorySortByTimeModel!.data!.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: CustomCardWidget<BookingDataSortByTime>(
                  title: S(context).recently_used,
                  data: state.bookingHistorySortByTimeModel?.data ??
                      <BookingDataSortByTime>[],
                  itemCount: state.bookingHistorySortByTimeModel?.data?.length,
                  margin: EdgeInsets.symmetric(horizontal: 0.w),
                  itemBuilder: (
                    BuildContext context,
                    BookingDataSortByTime item,
                    int index,
                  ) {
                    return BasicListTile(
                      icon: SvgAssets.icClock,
                      title: state.bookingHistorySortByTimeModel?.data?[index]
                          .addressName,
                      subtitle: state
                          .bookingHistorySortByTimeModel?.data?[index].address,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          LocationPickerPage.routeName,
                          arguments: LocationPickerArg(
                            locationPickParent: widget.args.locationPickParent,
                            bookingLocation:
                                LocationAddressModel.fromFrequentLocation(
                              state.bookingHistorySortByTimeModel?.data?[index],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            else
              const SizedBox.shrink(),
          ],
        );
      },
    );
  }

  Widget _currentLocationBtn(PlaceDetailModel? placeDetailModel) {
    if (placeDetailModel != null) {
      return _successCurrentLocationBtn(placeDetailModel);
    } else {
      return BlocBuilder<SearchBloc, SearchState>(
        buildWhen: (SearchState previous, SearchState current) {
          return previous.locationCurrentLoadState !=
              current.locationCurrentLoadState;
        },
        builder: (BuildContext context, SearchState state) {
          if (state.locationCurrentLoadState == LoadState.success) {
            return _successCurrentLocationBtn(
              state.placeDetailLocationCurrent!,
            );
          } else if (state.locationCurrentLoadState == LoadState.failure) {
            return _failureCurrentLocationTile();
          }
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        },
      );
    }
  }

  Widget _successCurrentLocationBtn(PlaceDetailModel placeDetailModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w).copyWith(top: 24.w),
      child: BasicListTile(
        title: S(context).current_location,
        subtitle: placeDetailModel.result?.formattedAddress ?? '',
        icon: SvgAssets.icCurrentLocation,
        onTap: () {
          _navigateToLocationPickerPage(placeDetailModel);
        },
      ),
    );
  }

  Widget _chooseFromMapBtn(PlaceDetailModel? placeDetailModel) {
    if (placeDetailModel != null) {
      return _successChooseFromMapBtn(placeDetailModel);
    }
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (SearchState previous, SearchState current) {
        return previous.locationCurrentLoadState !=
            current.locationCurrentLoadState;
      },
      builder: (BuildContext context, SearchState state) {
        if (state.locationCurrentLoadState == LoadState.success) {
          return _successChooseFromMapBtn(state.placeDetailLocationCurrent!);
        } else if (state.locationCurrentLoadState == LoadState.failure) {
          return _failureCurrentLocationTile();
        }
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      },
    );
  }

  Widget _successChooseFromMapBtn(PlaceDetailModel placeDetailModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w).copyWith(top: 20.w),
      child: BasicListTile(
        title: S(context).choose_from_map,
        icon: SvgAssets.icLocation,
        onTap: () {
          _navigateToLocationPickerPage(
            placeDetailModel,
          );
        },
      ),
    );
  }

  Widget _failureCurrentLocationTile() {
    return const BasicListTile(
      title: 'Cannot load current location',
    );
  }

  Widget _buildAddFavoriteLocationButton(SearchState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: BasicListTile(
        icon: SvgAssets.icPlus,
        title: S(context).add_address,
        subtitle: S(context).save_address_favourite,
        onTap: () {
          _navigateToAddFavoriteLocation(state);
        },
      ),
    );
  }

  void _navigateToLocationPickerPage(PlaceDetailModel placeDetailModel) {
    Navigator.pushNamed(
      context,
      LocationPickerPage.routeName,
      arguments: LocationPickerArg(
        locationPickParent: widget.args.locationPickParent,
        bookingLocation: LocationAddressModel.from(
          placeDetailModel,
        ),
      ),
    );
  }

  void _navigateToEditFavoriteLocation(
    FavoriteLocation data,
    SearchState state,
  ) {
    Navigator.pushNamed(
      context,
      FavoriteLocationPickerPage.routeName,
      arguments: FavoriteLocationPickerArg(
        favoriteLocation: data,
        modifyFavoriteLocation: _requestEditFavoriteLocation,
      ),
    );
  }

  void _navigateToAddFavoriteLocation(SearchState state) {
    Navigator.pushNamed(
      context,
      FavoriteLocationPickerPage.routeName,
      arguments: FavoriteLocationPickerArg(
        modifyFavoriteLocation: _requestAddFavoriteLocation,
      ),
    );
  }

  void _requestAddFavoriteLocation(FavoriteLocation data) {
    blocSearch.add(
      AddFavoriteLocationEvent(
        favoriteLocation: data,
      ),
    );
  }

  void _requestEditFavoriteLocation(FavoriteLocation data) {
    blocSearch.add(
      UpdateFavoriteLocationEvent(
        favoriteLocation: data,
      ),
    );
  }

  void _requestDeleteFavoriteLocation(FavoriteLocation data) {
    blocSearch.add(
      DeleteFavoriteLocationEvent(
        locationId: data.id!,
      ),
    );
  }

  _onTextChange(String text) {
    blocSearch.add(SearchAutoCompleteEvent(text.trim()));
  }
}
