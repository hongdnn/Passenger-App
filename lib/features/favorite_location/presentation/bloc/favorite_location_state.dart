import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:passenger/features/location/data/model/place_detail_model.dart';
import 'package:passenger/util/enum.dart';

class FavoriteLocationState {
  FavoriteLocationState({
    this.currentPosition,
    this.pickedPlace,
    this.pickedPlaceState = LoadState.none,
    this.initialPosition,
  });

  final LatLng? currentPosition;
  final PlaceDetailModel? pickedPlace;
  final LoadState pickedPlaceState;
  final LatLng? initialPosition;

  FavoriteLocationState copyWith({
    LatLng? currentPosition,
    PlaceDetailModel? pickedPlace,
    LoadState? pickedPlaceState,
    LatLng? initialPosition,
  }) {
    return FavoriteLocationState(
      currentPosition: currentPosition ?? this.currentPosition,
      pickedPlace: pickedPlace ?? this.pickedPlace,
      pickedPlaceState: pickedPlaceState ?? this.pickedPlaceState,
      initialPosition: initialPosition ?? this.initialPosition,
    );
  }
}
