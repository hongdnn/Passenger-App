// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finish_trip_driver_app_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinishTripDriverAppResponse _$FinishTripDriverAppResponseFromJson(
        Map<String, dynamic> json) =>
    FinishTripDriverAppResponse(
      driverBookingId: json['driverBookingId'] as String?,
      totalAmount: json['totalAmount'] as int? ?? 0,
      expressWayFee: json['expressWayFee'] as int? ?? 0,
      longitude: json['longitude'] as int? ?? 0,
      latitude: json['latitude'] as int? ?? 0,
    );

Map<String, dynamic> _$FinishTripDriverAppResponseToJson(
        FinishTripDriverAppResponse instance) =>
    <String, dynamic>{
      'driverBookingId': instance.driverBookingId,
      'totalAmount': instance.totalAmount,
      'expressWayFee': instance.expressWayFee,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };

FinishTripDriverAppModel _$FinishTripDriverAppModelFromJson(
        Map<String, dynamic> json) =>
    FinishTripDriverAppModel(
      errorMessage: json['errorMessage'] as String?,
      status: json['status'] as int?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FinishTripDriverAppModelToJson(
        FinishTripDriverAppModel instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'status': instance.status,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data();

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{};
