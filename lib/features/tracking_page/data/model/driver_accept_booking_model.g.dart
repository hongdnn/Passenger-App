// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_accept_booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverAcceptBookingModel _$DriverAcceptBookingModelFromJson(
        Map<String, dynamic> json) =>
    DriverAcceptBookingModel(
      errorMessage: json['errorMessage'] as String?,
      status: json['status'] as int?,
      data: json['data'] == null
          ? null
          : BookingData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DriverAcceptBookingModelToJson(
        DriverAcceptBookingModel instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'status': instance.status,
      'data': instance.data,
    };

DriverAcceptBookingRequestBody _$DriverAcceptBookingRequestBodyFromJson(
        Map<String, dynamic> json) =>
    DriverAcceptBookingRequestBody(
      carInfo: json['carInfo'] == null
          ? null
          : CarInfoRequestBody.fromJson(
              json['carInfo'] as Map<String, dynamic>),
      driverInfo: json['driverInfo'] == null
          ? null
          : DriverInfoRequestBody.fromJson(
              json['driverInfo'] as Map<String, dynamic>),
      driverToPickupDistance:
          (json['driverToPickupDistance'] as num?)?.toDouble(),
      driverToPickupTakeTime: json['driverToPickupTakeTime'] as int?,
    );

Map<String, dynamic> _$DriverAcceptBookingRequestBodyToJson(
        DriverAcceptBookingRequestBody instance) =>
    <String, dynamic>{
      'carInfo': instance.carInfo,
      'driverInfo': instance.driverInfo,
      'driverToPickupDistance': instance.driverToPickupDistance,
      'driverToPickupTakeTime': instance.driverToPickupTakeTime,
    };

CarInfoRequestBody _$CarInfoRequestBodyFromJson(Map<String, dynamic> json) =>
    CarInfoRequestBody();

Map<String, dynamic> _$CarInfoRequestBodyToJson(CarInfoRequestBody instance) =>
    <String, dynamic>{};

DriverInfoRequestBody _$DriverInfoRequestBodyFromJson(
        Map<String, dynamic> json) =>
    DriverInfoRequestBody(
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DriverInfoRequestBodyToJson(
        DriverInfoRequestBody instance) =>
    <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };
