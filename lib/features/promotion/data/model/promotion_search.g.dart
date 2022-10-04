// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionSearchRequestBody _$PromotionSearchRequestBodyFromJson(
        Map<String, dynamic> json) =>
    PromotionSearchRequestBody(
      userId: json['userId'] as String?,
      voucherCode: json['voucherCode'] as String?,
    );

Map<String, dynamic> _$PromotionSearchRequestBodyToJson(
        PromotionSearchRequestBody instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'voucherCode': instance.voucherCode,
    };

PromotionSearchResponse _$PromotionSearchResponseFromJson(
        Map<String, dynamic> json) =>
    PromotionSearchResponse(
      resultCode: json['resultCode'] as int?,
      errorMessage: json['errorMessage'] as String?,
      data: json['data'] == null
          ? null
          : PromotionData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PromotionSearchResponseToJson(
        PromotionSearchResponse instance) =>
    <String, dynamic>{
      'resultCode': instance.resultCode,
      'errorMessage': instance.errorMessage,
      'data': instance.data,
    };
