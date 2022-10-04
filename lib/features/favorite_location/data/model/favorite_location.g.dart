// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteLocationResponse _$FavoriteLocationResponseFromJson(
        Map<String, dynamic> json) =>
    FavoriteLocationResponse(
      status: json['status'] as int?,
      errorMessage: json['errorMessage'] as String?,
      data: json['data'] == null
          ? null
          : FavoriteLocation.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavoriteLocationResponseToJson(
        FavoriteLocationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'data': instance.data,
    };

FavoriteLocationListReponse _$FavoriteLocationListReponseFromJson(
        Map<String, dynamic> json) =>
    FavoriteLocationListReponse(
      status: json['status'] as int?,
      errorMessage: json['errorMessage'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FavoriteLocation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FavoriteLocationListReponseToJson(
        FavoriteLocationListReponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'data': instance.data,
    };

FavoriteDeleteResponse _$FavoriteDeleteResponseFromJson(
        Map<String, dynamic> json) =>
    FavoriteDeleteResponse(
      status: json['status'] as int?,
      errorMessage: json['errorMessage'] as String?,
      data: json['data'],
    );

Map<String, dynamic> _$FavoriteDeleteResponseToJson(
        FavoriteDeleteResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'data': instance.data,
    };

FavoriteLocation _$FavoriteLocationFromJson(Map<String, dynamic> json) =>
    FavoriteLocation(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      title: json['title'] as String?,
      createAt: json['createAt'] as String?,
      address: json['address'] as String?,
      addressName: json['addressName'] as String?,
      note: json['note'] as String?,
      updateAt: json['updateAt'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      googleId: json['googleId'] as String?,
      referenceId: json['referenceId'] as String?,
    );

Map<String, dynamic> _$FavoriteLocationToJson(FavoriteLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'addressName': instance.addressName,
      'note': instance.note,
      'createAt': instance.createAt,
      'updateAt': instance.updateAt,
      'referenceId': instance.referenceId,
      'googleId': instance.googleId,
    };
