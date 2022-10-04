// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_history_trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingHistoryTripModel _$BookingHistoryTripModelFromJson(
        Map<String, dynamic> json) =>
    BookingHistoryTripModel(
      status: json['status'] as int?,
      errorMessage: json['errorMessage'] as String?,
      data: json['data'] == null
          ? null
          : DataBooking.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingHistoryTripModelToJson(
        BookingHistoryTripModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'data': instance.data,
    };

DataBooking _$DataBookingFromJson(Map<String, dynamic> json) => DataBooking(
      currentPage: json['currentPage'] as int?,
      pageSize: json['pageSize'] as int?,
      totalCount: json['totalCount'] as int?,
      totalPage: json['totalPage'] as int?,
      bookings: (json['bookings'] as List<dynamic>?)
          ?.map((e) => BookingData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataBookingToJson(DataBooking instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'pageSize': instance.pageSize,
      'totalCount': instance.totalCount,
      'totalPage': instance.totalPage,
      'bookings': instance.bookings,
    };
