// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_booking_availability_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckBookingAvailabilityModel _$CheckBookingAvailabilityModelFromJson(
        Map<String, dynamic> json) =>
    CheckBookingAvailabilityModel(
      errorMessage: json['errorMessage'] as String?,
      status: json['status'] as int?,
      data: json['data'] == null
          ? null
          : DataCheckBookingAvailability.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckBookingAvailabilityModelToJson(
        CheckBookingAvailabilityModel instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'status': instance.status,
      'data': instance.data,
    };

DataCheckBookingAvailability _$DataCheckBookingAvailabilityFromJson(
        Map<String, dynamic> json) =>
    DataCheckBookingAvailability(
      isAvailable: json['isAvailable'] as bool?,
      booking: json['booking'] == null
          ? null
          : Booking.fromJson(json['booking'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataCheckBookingAvailabilityToJson(
        DataCheckBookingAvailability instance) =>
    <String, dynamic>{
      'isAvailable': instance.isAvailable,
      'booking': instance.booking,
    };

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
      id: json['id'] as String?,
    );

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      'id': instance.id,
    };
