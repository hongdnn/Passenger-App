import 'package:geolocator/geolocator.dart';
import 'package:passenger/features/location/data/model/place_detail_model.dart';

abstract class CurrentLocationRepo {
  // Get current Position from RAM cache
  //
  // If not exist, call refreshCurrentLocation
  // else return data from cache
  //
  Future<Position?> getCurrentPosition();

  // Force refresh Position
  Future<Position?> refreshCurrentPosition();

  // Get current PlaceDetailModel from RAM cache
  //
  // If not exist, call refreshCurrentLocationPlaceDetail
  // else return data from cache
  //
  Future<PlaceDetailModel?> getCurrentLocationPlaceDetail();

  // Force refresh PlaceDetailModel
  Future<PlaceDetailModel?> refreshCurrentLocationPlaceDetail();

  // Reset data
  void invalidate();

  PlaceDetailModel? get placeDetailModel;
}
