// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_pickup_passenger_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmPickupPassengerModel _$ConfirmPickupPassengerModelFromJson(
        Map<String, dynamic> json) =>
    ConfirmPickupPassengerModel(
      errorMessage: json['errorMessage'] as String?,
      status: json['status'] as int?,
      data: json['data'] == null
          ? null
          : BookingData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConfirmPickupPassengerModelToJson(
        ConfirmPickupPassengerModel instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'status': instance.status,
      'data': instance.data,
    };

ConfirmPickupPassengerRequestBody _$ConfirmPickupPassengerRequestBodyFromJson(
        Map<String, dynamic> json) =>
    ConfirmPickupPassengerRequestBody(
      bookingId: json['booking_id'] as String?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ConfirmPickupPassengerRequestBodyToJson(
        ConfirmPickupPassengerRequestBody instance) =>
    <String, dynamic>{
      'booking_id': instance.bookingId,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };
