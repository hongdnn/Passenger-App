// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_validate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionValidateRequest _$PromotionValidateRequestFromJson(
        Map<String, dynamic> json) =>
    PromotionValidateRequest(
      userId: json['userId'] as String?,
      promotionId: json['promotionId'] as int?,
      promotionCode: json['promotionCode'] as String?,
      voucherCode: json['voucherCode'] as String?,
      orderAmount: (json['orderAmount'] as num?)?.toDouble(),
      discountAmount: (json['discountAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PromotionValidateRequestToJson(
        PromotionValidateRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'promotionId': instance.promotionId,
      'promotionCode': instance.promotionCode,
      'voucherCode': instance.voucherCode,
      'orderAmount': instance.orderAmount,
      'discountAmount': instance.discountAmount,
    };

PromotionValidateResponseModel _$PromotionValidateResponseModelFromJson(
        Map<String, dynamic> json) =>
    PromotionValidateResponseModel(
      errorMessage: json['errorMessage'] as String?,
      status: json['status'] as int?,
      data: json['data'] == null
          ? null
          : PromotionValidateModel.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PromotionValidateResponseModelToJson(
        PromotionValidateResponseModel instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'status': instance.status,
      'data': instance.data,
    };

PromotionValidateModel _$PromotionValidateModelFromJson(
        Map<String, dynamic> json) =>
    PromotionValidateModel(
      isValid: json['isValid'] as bool?,
      discountAmount: (json['discountAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PromotionValidateModelToJson(
        PromotionValidateModel instance) =>
    <String, dynamic>{
      'isValid': instance.isValid,
      'discountAmount': instance.discountAmount,
    };
