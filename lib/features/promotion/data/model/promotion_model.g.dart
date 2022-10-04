// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionResponseModel _$PromotionResponseModelFromJson(
        Map<String, dynamic> json) =>
    PromotionResponseModel(
      errorMessage: json['errorMessage'] as String?,
      status: json['status'] as int?,
      data: json['data'] == null
          ? null
          : PromotionModelData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PromotionResponseModelToJson(
        PromotionResponseModel instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'status': instance.status,
      'data': instance.data,
    };

PromotionModelData _$PromotionModelDataFromJson(Map<String, dynamic> json) =>
    PromotionModelData(
      promotionList: (json['promotionList'] as List<dynamic>?)
          ?.map((e) => PromotionData.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PromotionModelDataToJson(PromotionModelData instance) =>
    <String, dynamic>{
      'promotionList': instance.promotionList,
      'pagination': instance.pagination,
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      currentPage: json['currentPage'] as int?,
      pageSize: json['pageSize'] as int?,
      hasNextPage: json['hasNextPage'] as bool?,
      hasPreviousPage: json['hasPreviousPage'] as bool?,
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'pageSize': instance.pageSize,
      'hasNextPage': instance.hasNextPage,
      'hasPreviousPage': instance.hasPreviousPage,
    };

PromotionData _$PromotionDataFromJson(Map<String, dynamic> json) =>
    PromotionData(
      promotionId: json['promotionId'] as int?,
      promotionName: json['promotionName'] as String?,
      shortDescription: json['shortDescription'] as String?,
      promotionLink: json['promotionLink'] as String?,
      promotionType: json['promotionType'] as String?,
      iconUrl: json['iconUrl'] as String?,
      type: json['type'] as String?,
      voucherCode: json['voucherCode'] as String?,
      promotionCode: json['promotionCode'] as String?,
      discount: (json['discount'] as num?)?.toDouble(),
      discountType: json['discountType'] as String?,
      discountFor: json['discountFor'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      maximumDiscount: (json['maximumDiscount'] as num?)?.toDouble(),
      applicationKey: json['applicationKey'] as String?,
    );

Map<String, dynamic> _$PromotionDataToJson(PromotionData instance) =>
    <String, dynamic>{
      'promotionId': instance.promotionId,
      'promotionName': instance.promotionName,
      'shortDescription': instance.shortDescription,
      'promotionLink': instance.promotionLink,
      'promotionType': instance.promotionType,
      'iconUrl': instance.iconUrl,
      'type': instance.type,
      'voucherCode': instance.voucherCode,
      'promotionCode': instance.promotionCode,
      'discount': instance.discount,
      'discountType': instance.discountType,
      'discountFor': instance.discountFor,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'maximumDiscount': instance.maximumDiscount,
      'applicationKey': instance.applicationKey,
    };
