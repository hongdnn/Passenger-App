import 'package:passenger/core/network/gg_client.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/location/data/model/geocoding_model.dart';
import 'package:passenger/features/location/data/model/place_detail_model.dart';
import 'package:passenger/features/location/data/repo/geocoding_repo.dart';
import 'package:passenger/features/location/data/repo/placedetail_repo.dart';

class PlaceDetailRepoImpl implements PlaceDetailRepo {
  PlaceDetailRepoImpl(this.ggClientApi, this._geocodingRepo);

  final GgClientApi ggClientApi;
  final GeocodingRepo _geocodingRepo;

  @override
  Future<DataState<PlaceDetailModel>> getPlaceDetail(
    String placeId,
  ) async {
    try {
      final PlaceDetailModel result =
          await ggClientApi.getPlaceDetail(placeId: placeId);

      return DataSuccess<PlaceDetailModel>(result);
    } on Exception catch (e) {
      return DataFailed<PlaceDetailModel>(e);
    }
  }

  @override
  Future<DataState<PlaceDetailModel>> getPlaceDetailByLatLong({
    required double lat,
    required double long,
  }) async {
    try {
      final DataState<AddressGeocoding> listAddressGeocoding =
          await _geocodingRepo.getAddressFormLocation(
        latitude: lat,
        longitude: long,
      );

      if (listAddressGeocoding.isError()) {
        return DataFailed<PlaceDetailModel>(
          listAddressGeocoding.error ?? Exception(),
        );
      }

      // Get place according to lat long
      final String placeId = listAddressGeocoding.data?.placeId ?? '';
      final DataState<PlaceDetailModel> placeDetailState =
          await getPlaceDetail(placeId);

      return DataSuccess<PlaceDetailModel>(placeDetailState.data!);
    } on Exception catch (e) {
      return DataFailed<PlaceDetailModel>(e);
    }
  }
}
