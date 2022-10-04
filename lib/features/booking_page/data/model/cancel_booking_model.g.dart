// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelBookingModel _$CancelBookingModelFromJson(Map<String, dynamic> json) =>
    CancelBookingModel(
      errorMessage: json['errorMessage'] as String?,
      status: json['status'] as int?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CancelBookingModelToJson(CancelBookingModel instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'status': instance.status,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      cancelTimes: json['cancelTimes'] as int?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'cancelTimes': instance.cancelTimes,
    };

CancelBookingBody _$CancelBookingBodyFromJson(Map<String, dynamic> json) =>
    CancelBookingBody(
      id: json['id'] as String?,
      cancelReason: json['cancelReason'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$CancelBookingBodyToJson(CancelBookingBody instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cancelReason': instance.cancelReason,
      'userId': instance.userId,
    };
