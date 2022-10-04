// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method_default_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodDefaultRequest _$PaymentMethodDefaultRequestFromJson(
        Map<String, dynamic> json) =>
    PaymentMethodDefaultRequest(
      userId: json['userId'] as String?,
      paymentTypeId: json['paymentTypeId'] as String?,
    );

Map<String, dynamic> _$PaymentMethodDefaultRequestToJson(
        PaymentMethodDefaultRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'paymentTypeId': instance.paymentTypeId,
    };
