// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_reason.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingOptionsResponse _$RatingOptionsResponseFromJson(
        Map<String, dynamic> json) =>
    RatingOptionsResponse(
      errorMessage: json['errorMessage'] as String?,
      status: json['status'] as int?,
      data: json['data'] == null
          ? null
          : RatingOptions.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RatingOptionsResponseToJson(
        RatingOptionsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'data': instance.data,
    };

RatingOptions _$RatingOptionsFromJson(Map<String, dynamic> json) =>
    RatingOptions(
      driverInfo: json['driverInfo'] == null
          ? null
          : DriverInfo.fromJson(json['driverInfo'] as Map<String, dynamic>),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      tipAmounts:
          (json['tipAmounts'] as List<dynamic>?)?.map((e) => e as num).toList(),
    );

Map<String, dynamic> _$RatingOptionsToJson(RatingOptions instance) =>
    <String, dynamic>{
      'driverInfo': instance.driverInfo,
      'reviews': instance.reviews,
      'tipAmounts': instance.tipAmounts,
    };

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      ratingStar:
          (json['ratingStar'] as List<dynamic>?)?.map((e) => e as num).toList(),
      reasons:
          (json['reasons'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'ratingStar': instance.ratingStar,
      'reasons': instance.reasons,
    };
