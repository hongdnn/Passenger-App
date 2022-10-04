import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:passenger/features/favorite_location/data/model/favorite_location.dart';

abstract class FavoriteLocationEvent {}

class GetAddressFromLatLngEvent extends FavoriteLocationEvent {
  GetAddressFromLatLngEvent({required this.latLng});

  final LatLng latLng;
}

class InitializeEvent extends FavoriteLocationEvent {
  InitializeEvent({this.favoriteLocation});

  final FavoriteLocation? favoriteLocation;
}
