// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geocoding_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeocodingModel _$GeocodingModelFromJson(Map<String, dynamic> json) =>
    GeocodingModel(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => AddressGeocoding.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$GeocodingModelToJson(GeocodingModel instance) =>
    <String, dynamic>{
      'results': instance.results,
      'status': instance.status,
    };

AddressGeocoding _$AddressGeocodingFromJson(Map<String, dynamic> json) =>
    AddressGeocoding(
      formattedAddress: json['formatted_address'] as String?,
      geometry: json['geometry'] == null
          ? null
          : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
      placeId: json['place_id'] as String?,
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AddressGeocodingToJson(AddressGeocoding instance) =>
    <String, dynamic>{
      'formatted_address': instance.formattedAddress,
      'geometry': instance.geometry,
      'place_id': instance.placeId,
      'types': instance.types,
    };

Geometry _$GeometryFromJson(Map<String, dynamic> json) => Geometry(
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GeometryToJson(Geometry instance) => <String, dynamic>{
      'location': instance.location,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };
