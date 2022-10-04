// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_items_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentItemsModel _$PaymentItemsModelFromJson(Map<String, dynamic> json) =>
    PaymentItemsModel(
      errorMessage: json['errorMessage'] as String?,
      status: json['status'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PaymentMethodData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentItemsModelToJson(PaymentItemsModel instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'status': instance.status,
      'data': instance.data,
    };
