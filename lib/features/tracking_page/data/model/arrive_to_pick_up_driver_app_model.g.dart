// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arrive_to_pick_up_driver_app_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArrivePickUpToDriverAppModel _$ArrivePickUpToDriverAppModelFromJson(
        Map<String, dynamic> json) =>
    ArrivePickUpToDriverAppModel(
      errorMessage: json['errorMessage'] as String?,
      status: json['status'] as int?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ArrivePickUpToDriverAppModelToJson(
        ArrivePickUpToDriverAppModel instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'status': instance.status,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data();

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{};
