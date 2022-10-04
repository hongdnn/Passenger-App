// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drafting_trip_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DraftingTripResponse _$DraftingTripResponseFromJson(
        Map<String, dynamic> json) =>
    DraftingTripResponse(
      errorMessage: json['errorMessage'] as String?,
      status: json['status'] as int?,
      data: json['data'] == null
          ? null
          : Trip.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DraftingTripResponseToJson(
        DraftingTripResponse instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'status': instance.status,
      'data': instance.data,
    };
