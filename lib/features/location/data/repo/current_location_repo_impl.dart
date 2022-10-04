// ignore: implementation_imports
import 'package:geolocator/geolocator.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/location/data/model/geocoding_model.dart';
import 'package:passenger/features/location/data/model/place_detail_model.dart';
import 'package:passenger/features/location/data/repo/current_location_repo.dart';
import 'package:passenger/features/location/data/repo/geocoding_repo.dart';
import 'package:passenger/features/location/data/repo/placedetail_repo.dart';

/// Must be a Singleton to work properly
class CurrentLocationRepoImpl extends CurrentLocationRepo {
  static const int getCurrentLocationTimeoutSeconds = 2; // 2 seconds

  Position? _position;
  PlaceDetailModel? _placeDetailModel;

  @override
  Future<Position?> getCurrentPosition() async {
    if (_position != null) return _position;

    return refreshCurrentPosition();
  }

  @override
  void invalidate() {
    _placeDetailModel = null;
    _position = null;
  }

  @override
  PlaceDetailModel? get placeDetailModel => _placeDetailModel;

  @override
  Future<Position?> refreshCurrentPosition() async {
    try {
      _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true,
        timeLimit: const Duration(seconds: getCurrentLocationTimeoutSeconds),
      );
      return _position;
    } on Exception catch (_) {
      _position = await Geolocator.getLastKnownPosition();
      return _position;
    }
  }

  @override
  Future<PlaceDetailModel?> getCurrentLocationPlaceDetail() async {
    if (_placeDetailModel != null) return _placeDetailModel;
    return refreshCurrentLocationPlaceDetail();
  }

  @override
  Future<PlaceDetailModel?> refreshCurrentLocationPlaceDetail() async {
    final Position? position = await getCurrentPosition();
    if (position == null) return null;

    // Get geo coding
    final GeocodingRepo geoRepo = getIt<GeocodingRepo>();
    final DataState<AddressGeocoding> addressGeocoding =
        await geoRepo.getAddressFormLocation(
      latitude: position.latitude,
      longitude: position.longitude,
    );
    if (addressGeocoding.isError()) return null;

    // Get place detail
    final String placeId = addressGeocoding.data?.placeId ?? '';
    if (placeId.isEmpty) return null;
    final PlaceDetailRepo placeDetailRepo = getIt<PlaceDetailRepo>();
    final DataState<PlaceDetailModel> placeDetailState =
        await placeDetailRepo.getPlaceDetail(placeId);
    if (placeDetailState.data == null || placeDetailState.isError()) {
      return null;
    }

    _placeDetailModel = placeDetailState.data!;
    return _placeDetailModel;
  }
}
