// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_car_location_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListCarLocationRequest _$ListCarLocationRequestFromJson(
        Map<String, dynamic> json) =>
    ListCarLocationRequest(
      depLat: (json['dep_lat'] as num).toDouble(),
      depLng: (json['dep_lng'] as num).toDouble(),
      desLat: (json['des_lat'] as num).toDouble(),
      desLng: (json['des_lng'] as num).toDouble(),
      distance: (json['distance'] as num).toDouble(),
    );

Map<String, dynamic> _$ListCarLocationRequestToJson(
        ListCarLocationRequest instance) =>
    <String, dynamic>{
      'dep_lat': instance.depLat,
      'dep_lng': instance.depLng,
      'des_lat': instance.desLat,
      'des_lng': instance.desLng,
      'distance': instance.distance,
    };
