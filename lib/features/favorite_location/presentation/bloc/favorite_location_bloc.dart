// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/favorite_location/presentation/bloc/favorite_location_event.dart';
import 'package:passenger/features/favorite_location/presentation/bloc/favorite_location_state.dart';
import 'package:passenger/features/location/data/model/place_detail_model.dart';
import 'package:passenger/features/location/data/repo/current_location_repo.dart';
import 'package:passenger/features/location/data/repo/placedetail_repo.dart';
import 'package:passenger/features/user/data/model/user.dart';
import 'package:passenger/features/user/data/repo/user_repo.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/util.dart';

class FavoriteLocationBloc
    extends Bloc<FavoriteLocationEvent, FavoriteLocationState> {
  FavoriteLocationBloc(
    this._currentLocationRepo,
    this._placeDetailRepo,
    this._userRepo,
  ) : super(
          FavoriteLocationState(
            pickedPlaceState: LoadState.loading,
          ),
        ) {
    on<InitializeEvent>(_initialize);
    on<GetAddressFromLatLngEvent>(
      _handleGetAddressFromLatLng,
      transformer: debounce(const Duration(milliseconds: defaultDebounceTime)),
    );
  }

  final CurrentLocationRepo _currentLocationRepo;
  final PlaceDetailRepo _placeDetailRepo;
  final UserRepo _userRepo;

  LatLng? get getCurrentPos => state.currentPosition;

  PlaceDetailModel? get getPickedPlace => state.pickedPlace;

  User getCurrentUser() {
    return _userRepo.getCurrentUser();
  }

  FutureOr<void> _initialize(
    InitializeEvent event,
    Emitter<FavoriteLocationState> emit,
  ) async {
    final Position? position = await _currentLocationRepo.getCurrentPosition();
    LatLng currentPosLatLng = LatLng(
      position?.latitude ?? 0,
      position?.longitude ?? 0,
    );
    LatLng initialPosition = currentPosLatLng;

    if (event.favoriteLocation != null) {
      // Is in edit mode, initial position should be FavoritePosition
      initialPosition = LatLng(
        event.favoriteLocation!.latitude ?? 0,
        event.favoriteLocation!.longitude ?? 0,
      );
    }

    emit(state.copyWith(pickedPlaceState: LoadState.loading));
    final DataState<PlaceDetailModel> placeDetailDs =
        await _placeDetailRepo.getPlaceDetailByLatLong(
      lat: initialPosition.latitude,
      long: initialPosition.longitude,
    );

    emit(
      state.copyWith(
        pickedPlaceState:
            placeDetailDs.isSuccess() ? LoadState.success : LoadState.failure,
        pickedPlace: placeDetailDs.data,
        currentPosition: currentPosLatLng,
        initialPosition: initialPosition,
      ),
    );
  }

  FutureOr<void> _handleGetAddressFromLatLng(
    GetAddressFromLatLngEvent event,
    Emitter<FavoriteLocationState> emit,
  ) async {
    // Lat long is the same, dont request again
    if (state.pickedPlace?.getLatitude == event.latLng.latitude &&
        state.pickedPlace?.getLongitude == event.latLng.longitude) {
      return;
    }

    emit(state.copyWith(pickedPlaceState: LoadState.loading));
    final DataState<PlaceDetailModel> placeDetailDs =
        await _placeDetailRepo.getPlaceDetailByLatLong(
      lat: event.latLng.latitude,
      long: event.latLng.longitude,
    );

    emit(
      state.copyWith(
        pickedPlaceState:
            placeDetailDs.isSuccess() ? LoadState.success : LoadState.failure,
        pickedPlace: placeDetailDs.data,
      ),
    );
  }
}
