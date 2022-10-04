// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_car_by_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListCarByLocationModel _$ListCarByLocationModelFromJson(
        Map<String, dynamic> json) =>
    ListCarByLocationModel(
      status: json['status'] as int?,
      errorMessage: json['errorMessage'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CarItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListCarByLocationModelToJson(
        ListCarByLocationModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'data': instance.data,
    };

CarItem _$CarItemFromJson(Map<String, dynamic> json) => CarItem(
      typeName: json['typeName'] as String?,
      carIcon: json['carIcon'] as String?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
    )
      ..length = json['length'] as int?
      ..offset = json['offset'] as int?;

Map<String, dynamic> _$CarItemToJson(CarItem instance) => <String, dynamic>{
      'typeName': instance.typeName,
      'carIcon': instance.carIcon,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'length': instance.length,
      'offset': instance.offset,
    };
