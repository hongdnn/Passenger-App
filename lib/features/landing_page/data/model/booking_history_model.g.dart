// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingHistoryModel _$BookingHistoryModelFromJson(Map<String, dynamic> json) =>
    BookingHistoryModel(
      status: json['status'] as int?,
      errorMessage: json['errorMessage'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BookingData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookingHistoryModelToJson(
        BookingHistoryModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'data': instance.data,
    };
