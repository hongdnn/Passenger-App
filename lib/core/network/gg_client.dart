import 'package:dio/dio.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/features/location/data/model/autocomplete_model.dart';
import 'package:passenger/features/location/data/model/direction_model.dart';
import 'package:passenger/features/location/data/model/geocoding_model.dart';
import 'package:passenger/features/location/data/model/place_detail_model.dart';
import 'package:retrofit/retrofit.dart';

part 'gg_client.g.dart';

@RestApi()
abstract class GgClientApi {
  factory GgClientApi(Dio dio, {String baseUrl}) = _GgClientApi;

  @GET('/place/autocomplete/json?key=$keyGGApi')
  Future<GgAutoComplete> getListAutoComplete({
    @Query('input') required String keyword,
    @Query('radius') int radius = 500,
  });

  @GET('/place/details/json?key=$keyGGApi')
  Future<PlaceDetailModel> getPlaceDetail({
    @Query('place_id') required String placeId,
  });

  @GET('/geocode/json?key=$keyGGApi')
  Future<GeocodingModel> getAddressFormLocation({
    @Query('latlng', encoded: false) required String latLng,
  });

  @GET(
    '/directions/json?key=$keyGGApi',
  )
  Future<DirectionModel> getDirectionFromOriginToDestination({
    @Query('origin') required String origin,
    @Query('destination') required String destination,
    @Query('mode') required String travelmode,
    @Query('avoidHighways') bool? avoidHighways,
    @Query('avoidTolls') bool? avoidTolls,
    @Query('avoidFerries') bool? avoidFerries,
    @Query('optimizeWaypoints') bool? optimizeWaypoints,
    @Query('alternatives') bool? alternatives,
  });

  @GET('/staticmap?key=$keyGGApi')
  Future<String> getStaticMap({
    @Query('size') required String size,
    @Query('zoom') required String zoom,
    @Query('maptype') required String maptype,
    @Query('center') required String center,
    @Query('markers') required String markers,
    // @Query('paths') required String paths,
  });
}
