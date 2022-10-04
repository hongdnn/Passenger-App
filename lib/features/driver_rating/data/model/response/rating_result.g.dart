// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingResultResponse _$RatingResultResponseFromJson(
        Map<String, dynamic> json) =>
    RatingResultResponse(
      errorMessage: json['errorMessage'] as String?,
      status: json['status'] as int?,
      data: json['data'] == null
          ? null
          : RatingResult.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RatingResultResponseToJson(
        RatingResultResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'data': instance.data,
    };

RatingResult _$RatingResultFromJson(Map<String, dynamic> json) => RatingResult(
      status: json['status'] as String?,
      submitRating: json['submitRating'] == null
          ? null
          : SubmitRating.fromJson(json['submitRating'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RatingResultToJson(RatingResult instance) =>
    <String, dynamic>{
      'submitRating': instance.submitRating,
      'status': instance.status,
    };

SubmitRating _$SubmitRatingFromJson(Map<String, dynamic> json) => SubmitRating(
      additionalComments: json['additionalComments'] as String?,
      bookingId: json['bookingId'] as String?,
      rating: json['rating'] as num?,
      ratingReasons: (json['ratingReasons'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      tipAmount: json['tipAmount'] as num?,
    );

Map<String, dynamic> _$SubmitRatingToJson(SubmitRating instance) =>
    <String, dynamic>{
      'bookingId': instance.bookingId,
      'rating': instance.rating,
      'ratingReasons': instance.ratingReasons,
      'tipAmount': instance.tipAmount,
      'additionalComments': instance.additionalComments,
    };
