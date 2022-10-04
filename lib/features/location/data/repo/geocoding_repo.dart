import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/location/data/model/geocoding_model.dart';

abstract class GeocodingRepo {
  Future<DataState<AddressGeocoding>> getAddressFormLocation({
    required double latitude,
    required double longitude,
  });
}
