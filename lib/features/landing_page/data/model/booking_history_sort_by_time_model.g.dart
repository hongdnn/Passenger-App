// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_history_sort_by_time_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingHistorySortByTimeModel _$BookingHistorySortByTimeModelFromJson(
        Map<String, dynamic> json) =>
    BookingHistorySortByTimeModel(
      status: json['status'] as int?,
      errorMessage: json['errorMessage'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => BookingDataSortByTime.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookingHistorySortByTimeModelToJson(
        BookingHistorySortByTimeModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'data': instance.data,
    };

BookingDataSortByTime _$BookingDataSortByTimeFromJson(
        Map<String, dynamic> json) =>
    BookingDataSortByTime(
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      address: json['address'] as String?,
      googleId: json['googleId'] as String?,
      referenceId: json['referenceId'] as String?,
      addressName: json['addressName'] as String?,
    );

Map<String, dynamic> _$BookingDataSortByTimeToJson(
        BookingDataSortByTime instance) =>
    <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'address': instance.address,
      'googleId': instance.googleId,
      'referenceId': instance.referenceId,
      'addressName': instance.addressName,
    };
