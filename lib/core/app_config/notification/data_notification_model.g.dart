// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataNotificationModel _$DataNotificationModelFromJson(
        Map<String, dynamic> json) =>
    DataNotificationModel(
      actionCode: json['action_code'] as String?,
      userId: json['user_id'] as String?,
      deviceId: json['device_id'] as String?,
      bookingId: json['booking_id'] as String?,
      destinationNo: json['destination_no'] as String?,
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
      bookingStatus: json['bookingStatus'] as String?,
    );

Map<String, dynamic> _$DataNotificationModelToJson(
        DataNotificationModel instance) =>
    <String, dynamic>{
      'action_code': instance.actionCode,
      'user_id': instance.userId,
      'device_id': instance.deviceId,
      'booking_id': instance.bookingId,
      'destination_no': instance.destinationNo,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'bookingStatus': instance.bookingStatus,
    };
