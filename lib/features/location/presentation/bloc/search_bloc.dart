import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/location/data/model/autocomplete_model.dart';
import 'package:passenger/features/favorite_location/data/model/favorite_location.dart';
import 'package:passenger/features/location/data/model/geocoding_model.dart';
import 'package:passenger/features/location/data/model/place_detail_model.dart';
import 'package:passenger/features/location/data/repo/autocomplete_repo.dart';
import 'package:passenger/features/location/data/repo/current_location_repo.dart';
import 'package:passenger/features/favorite_location/data/repo/favorite_location_repo.dart';
import 'package:passenger/features/location/data/repo/geocoding_repo.dart';
import 'package:passenger/features/location/data/repo/placedetail_repo.dart';
import 'package:passenger/features/user/data/model/user.dart';
import 'package:passenger/features/user/data/repo/user_repo.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/util.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(
    this._autocompleteRepo,
    this._favoriteLocationRepo,
    this._placeDetailRepo,
    this._geocodingRepo,
    this._currentLocationRepo,
    this._userRepo,
  ) : super(SearchState()) {
    on<GetFavoriteLocationsEvent>(
      _handleGetFavoriteLocations,
    );
    on<DeleteFavoriteLocationEvent>(
      _handleDeleteFavoriteLocation,
    );
    on<AddFavoriteLocationEvent>(
      _handleAddFavoriteLocation,
    );
    on<UpdateFavoriteLocationEvent>(
      _handleUpdateFavoriteLocation,
    );
    on<SearchAutoCompleteEvent>(
      _handleAutoComplete,
      transformer: debounce(const Duration(milliseconds: defaultDebounceTime)),
    );
    on<GetPlaceDetailEvent>(
      _handleGetPlaceDetail,
    );
    on<GetAddressFromLatLngEvent>(
      _handleGetAddressFromLatLng,
      transformer: debounce(const Duration(milliseconds: defaultDebounceTime)),
    );
    on<GetCurrentLocationEvent>(getCurrentLocation);
  }

  final AutocompleteRepo _autocompleteRepo;
  final FavoriteLocationRepo _favoriteLocationRepo;
  final PlaceDetailRepo _placeDetailRepo;
  final GeocodingRepo _geocodingRepo;
  final CurrentLocationRepo _currentLocationRepo;
  final UserRepo _userRepo;

  User getCurrentUser() {
    return _userRepo.getCurrentUser();
  }

  FutureOr<void> _handleAutoComplete(
    SearchAutoCompleteEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(
      state.copyWith(
        state: LoadState.loading,
        listAutoComplete: null,
        keyword: event.keyword,
      ),
    );

    final DataState<GgAutoComplete> ggAutoCompleteState =
        await _autocompleteRepo.getListGGAutocomplete(event.keyword);

    emit(
      state.copyWith(
        state: ggAutoCompleteState.isSuccess()
            ? LoadState.success
            : LoadState.failure,
        listAutoComplete: ggAutoCompleteState.isSuccess()
            ? ggAutoCompleteState.data
            : (state.listAutoComplete ?? ggAutoCompleteState.data),
        keyword: event.keyword,
      ),
    );
  }

  Future<void> _handleGetFavoriteLocations(
    GetFavoriteLocationsEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(
      state.copyWith(
        favLocationStatus: LoadState.loading,
        listFavoriteLocation: null,
      ),
    );
    final DataState<List<FavoriteLocation>> dataState =
        await _favoriteLocationRepo
            .getFavoriteLocationByUserId(getCurrentUser().id);

    emit(
      state.copyWith(
        favLocationStatus:
            dataState.isSuccess() ? LoadState.success : LoadState.failure,
        listFavoriteLocation: dataState.isSuccess() ? dataState.data : null,
      ),
    );
  }

  Future<void> _handleDeleteFavoriteLocation(
    DeleteFavoriteLocationEvent event,
    Emitter<SearchState> emit,
  ) async {
    String locationId = event.locationId;

    final bool deletedLocationDataState =
        await _favoriteLocationRepo.deleteFavoriteLocationById(locationId);

    if (deletedLocationDataState == true) {
      final DataState<List<FavoriteLocation>> listFavLocationdataState =
          await _favoriteLocationRepo
              .getFavoriteLocationByUserId(getCurrentUser().id);

      emit(
        state.copyWith(
          favLocationStatus: listFavLocationdataState.isSuccess()
              ? LoadState.success
              : LoadState.failure,
          listFavoriteLocation: listFavLocationdataState.data,
        ),
      );
    } else {
      emit(
        state.copyWith(
          favLocationStatus: LoadState.failure,
          listFavoriteLocation: state.listFavoriteLocation,
        ),
      );
    }
  }

  Future<void> _handleAddFavoriteLocation(
    AddFavoriteLocationEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(
      state.copyWith(
        favLocationStatus: LoadState.loading,
      ),
    );

    FavoriteLocation location = event.favoriteLocation;

    final DataState<FavoriteLocation> addLocationDataState =
        await _favoriteLocationRepo.addFavoriteLocation(location);
    if (addLocationDataState.isSuccess()) {
      final DataState<List<FavoriteLocation>> listFavLocationdataState =
          await _favoriteLocationRepo
              .getFavoriteLocationByUserId(getCurrentUser().id);

      emit(
        state.copyWith(
          favLocationStatus: listFavLocationdataState.isSuccess()
              ? LoadState.success
              : LoadState.failure,
          listFavoriteLocation: listFavLocationdataState.data,
        ),
      );
    } else {
      emit(
        state.copyWith(
          favLocationStatus: LoadState.failure,
          listFavoriteLocation: state.listFavoriteLocation,
        ),
      );
    }
  }

  Future<void> _handleUpdateFavoriteLocation(
    UpdateFavoriteLocationEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(
      state.copyWith(
        state: LoadState.loading,
      ),
    );

    FavoriteLocation location = event.favoriteLocation;
    String userId = _userRepo.getCurrentUser().id;

    final DataState<FavoriteLocation> updatedLocationDataState =
        await _favoriteLocationRepo.updateFavoriteLocation(location);
    if (updatedLocationDataState.isSuccess()) {
      final DataState<List<FavoriteLocation>> listFavLocationdataState =
          await _favoriteLocationRepo.getFavoriteLocationByUserId(userId);

      emit(
        state.copyWith(
          state: listFavLocationdataState.isSuccess()
              ? LoadState.success
              : LoadState.failure,
          listFavoriteLocation: listFavLocationdataState.data,
        ),
      );
    } else {
      emit(
        state.copyWith(
          state: LoadState.failure,
          listFavoriteLocation: state.listFavoriteLocation,
        ),
      );
    }
  }

  FutureOr<void> _handleGetAddressFromLatLng(
    GetAddressFromLatLngEvent event,
    Emitter<SearchState> emit,
  ) async {
    double? latitude = event.latitude;
    double? longitude = event.longitude;

    emit(
      state.copyWith(
        geoCodingLoadState: LoadState.loading,
        listAutoComplete: null,
      ),
    );

    if (latitude != null && longitude != null) {
      try {
        final DataState<AddressGeocoding> listAddressGeocoding =
            await _geocodingRepo.getAddressFormLocation(
          latitude: latitude,
          longitude: longitude,
        );
        if (listAddressGeocoding.isSuccess()) {
          final String placeID = listAddressGeocoding.data?.placeId ?? '';
          final DataState<PlaceDetailModel> placeDetailState =
              await _placeDetailRepo.getPlaceDetail(placeID);
          emit(
            state.copyWith(
              geoCodingLoadState: placeDetailState.isSuccess()
                  ? LoadState.success
                  : LoadState.failure,
              placeToAddOrToGo: placeDetailState.data,
            ),
          );
        } else {
          emit(
            state.copyWith(
              geoCodingLoadState: LoadState.failure,
            ),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(
            geoCodingLoadState: LoadState.failure,
          ),
        );
      }
    } else {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        final PlaceDetailModel? placeDetailModel =
            await _currentLocationRepo.getCurrentLocationPlaceDetail();

        if (placeDetailModel != null) {
          emit(
            state.copyWith(
              geoCodingLoadState: LoadState.success,
              placeToAddOrToGo: placeDetailModel,
            ),
          );
        } else {
          state.copyWith(
            geoCodingLoadState: LoadState.failure,
          );
        }
      } else {
        // Do on permission denided
      }
    }
  }

  FutureOr<void> _handleGetPlaceDetail(
    GetPlaceDetailEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(
      state.copyWith(
        getPlaceDetailStatus: LoadState.loading,
      ),
    );

    final DataState<PlaceDetailModel> placeDetailState =
        await _placeDetailRepo.getPlaceDetail(event.placeId);

    emit(
      state.copyWith(
        getPlaceDetailStatus: placeDetailState.isSuccess()
            ? LoadState.success
            : LoadState.failure,
        placeDetail: placeDetailState.isSuccess()
            ? placeDetailState.data
            : (state.placeDetail ?? placeDetailState.data),
      ),
    );
  }

  FutureOr<void> getCurrentLocation(
    GetCurrentLocationEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(locationCurrentLoadState: LoadState.loading));
    PlaceDetailModel? placeDetailModel =
        await _currentLocationRepo.refreshCurrentLocationPlaceDetail();
    emit(
      state.copyWith(
        placeDetailLocationCurrent: placeDetailModel,
        locationCurrentLoadState:
            placeDetailModel == null ? LoadState.failure : LoadState.success,
      ),
    );
  }
}
