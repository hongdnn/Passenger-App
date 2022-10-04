import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/location/data/model/place_detail_model.dart';

abstract class PlaceDetailRepo {
  Future<DataState<PlaceDetailModel>> getPlaceDetail(String placeId);

  Future<DataState<PlaceDetailModel>> getPlaceDetailByLatLong({
    required double lat,
    required double long,
  });
}
