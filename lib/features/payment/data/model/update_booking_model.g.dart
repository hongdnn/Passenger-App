// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateBookingPayloadModel _$UpdateBookingPayloadModelFromJson(
        Map<String, dynamic> json) =>
    UpdateBookingPayloadModel(
      userId: json['userId'] as String?,
      paymentMethodId: json['paymentMethodId'] as String?,
    );

Map<String, dynamic> _$UpdateBookingPayloadModelToJson(
        UpdateBookingPayloadModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'paymentMethodId': instance.paymentMethodId,
    };
