import 'package:passenger/core/network/gg_client.dart';
import 'package:passenger/features/location/data/model/geocoding_model.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/location/data/repo/geocoding_repo.dart';

class GeocodingRepoImlp implements GeocodingRepo {
  GeocodingRepoImlp(this._ggClientApi);

  final GgClientApi _ggClientApi;
  @override
  Future<DataState<AddressGeocoding>> getAddressFormLocation({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final GeocodingModel result = await _ggClientApi.getAddressFormLocation(
        latLng: '$latitude,$longitude',
      );

      return DataSuccess<AddressGeocoding>(
        result.results?.first ?? AddressGeocoding(),
      );
    } on Exception catch (e) {
      return DataFailed<AddressGeocoding>(e);
    }
  }
}
