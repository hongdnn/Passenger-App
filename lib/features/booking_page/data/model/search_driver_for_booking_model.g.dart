// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_driver_for_booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchDriverForBookingModel _$SearchDriverForBookingModelFromJson(
        Map<String, dynamic> json) =>
    SearchDriverForBookingModel(
      status: json['status'] as int?,
      errorMessage: json['errorMessage'] as String?,
      data: json['data'] == null
          ? null
          : DataSearchDriverForBooking.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchDriverForBookingModelToJson(
        SearchDriverForBookingModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'data': instance.data,
    };

DataSearchDriverForBooking _$DataSearchDriverForBookingFromJson(
        Map<String, dynamic> json) =>
    DataSearchDriverForBooking(
      id: json['id'] as String?,
      driverAppBookingId: json['driverAppBookingId'] as String?,
    );

Map<String, dynamic> _$DataSearchDriverForBookingToJson(
        DataSearchDriverForBooking instance) =>
    <String, dynamic>{
      'id': instance.id,
      'driverAppBookingId': instance.driverAppBookingId,
    };

SearchDriverForBookingResponse _$SearchDriverForBookingResponseFromJson(
        Map<String, dynamic> json) =>
    SearchDriverForBookingResponse(
      bookingId: json['bookingId'] as String?,
    );

Map<String, dynamic> _$SearchDriverForBookingResponseToJson(
        SearchDriverForBookingResponse instance) =>
    <String, dynamic>{
      'bookingId': instance.bookingId,
    };
