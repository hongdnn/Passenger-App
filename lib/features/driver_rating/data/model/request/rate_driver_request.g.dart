// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_driver_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RateDriverRequest _$RateDriverRequestFromJson(Map<String, dynamic> json) =>
    RateDriverRequest(
      bookingId: json['bookingId'] as String?,
      rating: json['rating'] as num?,
      ratingReasons: (json['ratingReasons'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      tipAmount: json['tipAmount'] as num?,
      additionalComments: json['additionalComments'] as String?,
    );

Map<String, dynamic> _$RateDriverRequestToJson(RateDriverRequest instance) =>
    <String, dynamic>{
      'bookingId': instance.bookingId,
      'rating': instance.rating,
      'ratingReasons': instance.ratingReasons,
      'tipAmount': instance.tipAmount,
      'additionalComments': instance.additionalComments,
    };
