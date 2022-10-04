part of 'search_bloc.dart';

class SearchState {
  SearchState({
    this.state,
    this.locationCurrentLoadState,
    this.geoCodingLoadState,
    this.listAutoComplete,
    this.keyword,
    this.listFavoriteLocation,
    this.favLocationStatus,
    this.placeDetail,
    this.placeId,
    this.placeToAddOrToGo,
    this.placeDetailLocationCurrent,
    this.getPlaceDetailStatus,
    this.getBookingHistorySortByTimeLoadState,
  });

  final LoadState? state;
  final LoadState? locationCurrentLoadState;
  final LoadState? geoCodingLoadState;
  final LoadState? getBookingHistorySortByTimeLoadState;
  final GgAutoComplete? listAutoComplete;
  final String? keyword;
  final List<FavoriteLocation>? listFavoriteLocation;
  final LoadState? favLocationStatus;
  final PlaceDetailModel? placeDetail;
  final String? placeId;
  final PlaceDetailModel? placeToAddOrToGo;
  final PlaceDetailModel? placeDetailLocationCurrent;
  final LoadState? getPlaceDetailStatus;

  SearchState copyWith({
    LoadState? state,
    LoadState? getPlaceDetailStatus,
    LoadState? locationCurrentLoadState,
    LoadState? geoCodingLoadState,
    LoadState? getBookingHistorySortByTimeLoadState,
    GgAutoComplete? listAutoComplete,
    String? keyword,
    List<FavoriteLocation>? listFavoriteLocation,
    LoadState? favLocationStatus,
    PlaceDetailModel? placeDetail,
    String? placeId,
    PlaceDetailModel? placeToAddOrToGo,
    PlaceDetailModel? placeDetailLocationCurrent,
  }) {
    return SearchState(
      state: state ?? this.state,
      getPlaceDetailStatus: getPlaceDetailStatus,
      locationCurrentLoadState:
          locationCurrentLoadState ?? this.locationCurrentLoadState,
      geoCodingLoadState: geoCodingLoadState ?? this.geoCodingLoadState,
      getBookingHistorySortByTimeLoadState:
          getBookingHistorySortByTimeLoadState ??
              this.getBookingHistorySortByTimeLoadState,
      listAutoComplete: listAutoComplete ?? this.listAutoComplete,
      keyword: keyword ?? this.keyword,
      listFavoriteLocation: listFavoriteLocation ?? this.listFavoriteLocation,
      favLocationStatus: favLocationStatus ?? this.favLocationStatus,
      placeDetail: placeDetail ?? this.placeDetail,
      placeId: placeId ?? this.placeId,
      placeToAddOrToGo: placeToAddOrToGo ?? this.placeToAddOrToGo,
      placeDetailLocationCurrent:
          placeDetailLocationCurrent ?? this.placeDetailLocationCurrent,
    );
  }
}
