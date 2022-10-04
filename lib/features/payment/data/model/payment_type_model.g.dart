// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentTypeModel _$PaymentTypeModelFromJson(Map<String, dynamic> json) =>
    PaymentTypeModel(
      errorMessage: json['errorMessage'] as String?,
      status: json['status'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PaymentType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentTypeModelToJson(PaymentTypeModel instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'status': instance.status,
      'data': instance.data,
    };

PaymentType _$PaymentTypeFromJson(Map<String, dynamic> json) => PaymentType(
      id: json['id'] as String?,
      name: json['name'] as String?,
      icon: json['icon'] as String?,
      isCard: json['isCard'] as bool?,
    );

Map<String, dynamic> _$PaymentTypeToJson(PaymentType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'isCard': instance.isCard,
    };
