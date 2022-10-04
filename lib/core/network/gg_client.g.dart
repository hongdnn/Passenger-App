// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gg_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _GgClientApi implements GgClientApi {
  _GgClientApi(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<GgAutoComplete> getListAutoComplete(
      {required keyword, radius = 500}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'input': keyword,
      r'radius': radius
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        GgAutoComplete>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/place/autocomplete/json?key=AIzaSyCi8bC5OHtvA57WuSihJSOpXuzfiv20sW0',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GgAutoComplete.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PlaceDetailModel> getPlaceDetail({required placeId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'place_id': placeId};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        PlaceDetailModel>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/place/details/json?key=AIzaSyCi8bC5OHtvA57WuSihJSOpXuzfiv20sW0',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PlaceDetailModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GeocodingModel> getAddressFormLocation({required latLng}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'latlng': latLng};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GeocodingModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    '/geocode/json?key=AIzaSyCi8bC5OHtvA57WuSihJSOpXuzfiv20sW0',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GeocodingModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DirectionModel> getDirectionFromOriginToDestination(
      {required origin,
      required destination,
      required travelmode,
      avoidHighways,
      avoidTolls,
      avoidFerries,
      optimizeWaypoints,
      alternatives}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'origin': origin,
      r'destination': destination,
      r'mode': travelmode,
      r'avoidHighways': avoidHighways,
      r'avoidTolls': avoidTolls,
      r'avoidFerries': avoidFerries,
      r'optimizeWaypoints': optimizeWaypoints,
      r'alternatives': alternatives
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DirectionModel>(Options(
                method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options,
                '/directions/json?key=AIzaSyCi8bC5OHtvA57WuSihJSOpXuzfiv20sW0',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DirectionModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<String> getStaticMap(
      {required size,
      required zoom,
      required maptype,
      required center,
      required markers}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'size': size,
      r'zoom': zoom,
      r'maptype': maptype,
      r'center': center,
      r'markers': markers
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<String>(_setStreamType<String>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options,
                '/staticmap?key=AIzaSyCi8bC5OHtvA57WuSihJSOpXuzfiv20sW0',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
