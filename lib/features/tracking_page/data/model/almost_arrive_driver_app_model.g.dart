// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'almost_arrive_driver_app_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlmostArriveDriverAppModel _$AlmostArriveDriverAppModelFromJson(
        Map<String, dynamic> json) =>
    AlmostArriveDriverAppModel(
      errorMessage: json['errorMessage'] as String?,
      status: json['status'] as int?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AlmostArriveDriverAppModelToJson(
        AlmostArriveDriverAppModel instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'status': instance.status,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data();

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{};
