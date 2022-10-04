// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingDetailModel _$BookingDetailModelFromJson(Map<String, dynamic> json) =>
    BookingDetailModel(
      errorMessage: json['errorMessage'] as String?,
      status: json['status'] as int?,
      data: json['data'] == null
          ? null
          : BookingData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingDetailModelToJson(BookingDetailModel instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'status': instance.status,
      'data': instance.data,
    };
