// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finish_trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinishTripModel _$FinishTripModelFromJson(Map<String, dynamic> json) =>
    FinishTripModel(
      errorMessage: json['errorMessage'] as String?,
      status: json['status'] as int?,
      data: json['data'] == null
          ? null
          : BookingData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FinishTripModelToJson(FinishTripModel instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'status': instance.status,
      'data': instance.data,
    };

FinishTripRequestBody _$FinishTripRequestBodyFromJson(
        Map<String, dynamic> json) =>
    FinishTripRequestBody(
      bookingId: json['booking_id'] as String?,
      waitingFreeNote: json['waiting_free_note'] as String?,
      waitingFreeAmount: json['waiting_free_amount'] as int?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FinishTripRequestBodyToJson(
        FinishTripRequestBody instance) =>
    <String, dynamic>{
      'booking_id': instance.bookingId,
      'waiting_free_note': instance.waitingFreeNote,
      'waiting_free_amount': instance.waitingFreeAmount,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };
