// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upsert_fcm_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FcmTokenResponse _$FcmTokenResponseFromJson(Map<String, dynamic> json) =>
    FcmTokenResponse(
      token: json['token'] as String?,
      deviceId: json['deviceId'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$FcmTokenResponseToJson(FcmTokenResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'deviceId': instance.deviceId,
      'userId': instance.userId,
    };

FcmTokenModel _$FcmTokenModelFromJson(Map<String, dynamic> json) =>
    FcmTokenModel(
      errorMessage: json['errorMessage'] as String?,
      status: json['status'] as int?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FcmTokenModelToJson(FcmTokenModel instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'status': instance.status,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as String?,
      token: json['token'] as String?,
      userId: json['userId'] as String?,
      deviceId: json['deviceId'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'userId': instance.userId,
      'deviceId': instance.deviceId,
    };
