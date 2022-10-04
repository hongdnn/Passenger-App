// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodModel _$PaymentMethodModelFromJson(Map<String, dynamic> json) =>
    PaymentMethodModel(
      errorMessage: json['errorMessage'] as String?,
      status: json['status'] as int?,
      data: json['data'] == null
          ? null
          : PaymentMethodData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentMethodModelToJson(PaymentMethodModel instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'status': instance.status,
      'data': instance.data,
    };

PaymentMethodData _$PaymentMethodDataFromJson(Map<String, dynamic> json) =>
    PaymentMethodData(
      userId: json['userId'] as String?,
      name: json['name'] as String?,
      icon: json['icon'] as String?,
      note: json['note'] as String?,
      status: json['status'] as int?,
      order: json['order'] as int?,
      isDefault: json['isDefault'],
      paymentType: json['paymentType'] == null
          ? null
          : PaymentType.fromJson(json['paymentType'] as Map<String, dynamic>),
      nickname: json['nickname'] as String?,
      id: json['id'] as String?,
      createAt: json['createAt'] as String?,
      updateAt: json['updateAt'] as String?,
      cardLastDigits: json['cardLastDigits'] as String?,
      paymentIcon: json['paymentIcon'] as String?,
    );

Map<String, dynamic> _$PaymentMethodDataToJson(PaymentMethodData instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'icon': instance.icon,
      'note': instance.note,
      'status': instance.status,
      'order': instance.order,
      'isDefault': instance.isDefault,
      'paymentType': instance.paymentType,
      'nickname': instance.nickname,
      'id': instance.id,
      'createAt': instance.createAt,
      'updateAt': instance.updateAt,
      'cardLastDigits': instance.cardLastDigits,
      'paymentIcon': instance.paymentIcon,
    };

PaymentRequestBody _$PaymentRequestBodyFromJson(Map<String, dynamic> json) =>
    PaymentRequestBody(
      userId: json['userId'] as String?,
      name: json['name'] as String?,
      nickname: json['nickname'] as String?,
      paymentTypeId: json['paymentTypeId'] as String?,
      order: json['order'] as int?,
      cardNum: json['cardNum'] as String?,
      cardCvv: json['cardCvv'] as String?,
      cardExpiryMonth: json['cardExpiryMonth'] as int?,
      cardExpiryYear: json['cardExpiryYear'] as int?,
    );

Map<String, dynamic> _$PaymentRequestBodyToJson(PaymentRequestBody instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'nickname': instance.nickname,
      'paymentTypeId': instance.paymentTypeId,
      'order': instance.order,
      'cardNum': instance.cardNum,
      'cardCvv': instance.cardCvv,
      'cardExpiryMonth': instance.cardExpiryMonth,
      'cardExpiryYear': instance.cardExpiryYear,
    };

PaymentMethodUpdateRequestBody _$PaymentMethodUpdateRequestBodyFromJson(
        Map<String, dynamic> json) =>
    PaymentMethodUpdateRequestBody(
      nickname: json['nickname'] as String?,
    );

Map<String, dynamic> _$PaymentMethodUpdateRequestBodyToJson(
        PaymentMethodUpdateRequestBody instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
    };
