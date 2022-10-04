// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_booking_driver_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CanceBookingDriverResponse _$CanceBookingDriverResponseFromJson(
        Map<String, dynamic> json) =>
    CanceBookingDriverResponse(
      driverBookingId: json['driverBookingId'] as String?,
      cancelReason: json['cancelReason'] as String? ?? 'cancelReason',
      longitude: json['longitude'] as int? ?? 0,
      latitude: json['latitude'] as int? ?? 0,
    );

Map<String, dynamic> _$CanceBookingDriverResponseToJson(
        CanceBookingDriverResponse instance) =>
    <String, dynamic>{
      'driverBookingId': instance.driverBookingId,
      'cancelReason': instance.cancelReason,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };

CanceBookingDriverModel _$CanceBookingDriverModelFromJson(
        Map<String, dynamic> json) =>
    CanceBookingDriverModel(
      errorMessage: json['errorMessage'] as String?,
      status: json['status'] as int?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CanceBookingDriverModelToJson(
        CanceBookingDriverModel instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'status': instance.status,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data();

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{};
