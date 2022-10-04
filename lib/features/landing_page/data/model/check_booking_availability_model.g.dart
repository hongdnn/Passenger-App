// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_booking_availability_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckBookingAvailabilityModel _$CheckBookingAvailabilityModelFromJson(
        Map<String, dynamic> json) =>
    CheckBookingAvailabilityModel(
      errorMessage: json['errorMessage'] as String?,
      resultCode: json['resultCode'] as int?,
      data: json['data'] == null
          ? null
          : CheckBookingAvailabilityData.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckBookingAvailabilityModelToJson(
        CheckBookingAvailabilityModel instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'resultCode': instance.resultCode,
      'data': instance.data,
    };

CheckBookingAvailabilityData _$CheckBookingAvailabilityDataFromJson(
        Map<String, dynamic> json) =>
    CheckBookingAvailabilityData(
      isAvailable: json['isAvailable'] as bool?,
      bookingId: json['bookingId'] as String?,
    )..lockTo = json['lockTo'] as String?;

Map<String, dynamic> _$CheckBookingAvailabilityDataToJson(
        CheckBookingAvailabilityData instance) =>
    <String, dynamic>{
      'isAvailable': instance.isAvailable,
      'bookingId': instance.bookingId,
      'lockTo': instance.lockTo,
    };
