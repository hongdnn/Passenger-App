// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_pick_up_passenger_driver_app_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmPickUpPassengerResponse _$ConfirmPickUpPassengerResponseFromJson(
        Map<String, dynamic> json) =>
    ConfirmPickUpPassengerResponse(
      driverBookingId: json['driverBookingId'] as String?,
      longitude: json['longitude'] as int? ?? 0,
      latitude: json['latitude'] as int? ?? 0,
      arrivedTime: json['arrivedTime'] == null
          ? null
          : DateTime.parse(json['arrivedTime'] as String),
    );

Map<String, dynamic> _$ConfirmPickUpPassengerResponseToJson(
        ConfirmPickUpPassengerResponse instance) =>
    <String, dynamic>{
      'driverBookingId': instance.driverBookingId,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'arrivedTime': instance.arrivedTime?.toIso8601String(),
    };

ConfirmPickUpPassengerModel _$ConfirmPickUpPassengerModelFromJson(
        Map<String, dynamic> json) =>
    ConfirmPickUpPassengerModel(
      errorMessage: json['errorMessage'] as String?,
      status: json['status'] as int?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConfirmPickUpPassengerModelToJson(
        ConfirmPickUpPassengerModel instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'status': instance.status,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data();

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{};
