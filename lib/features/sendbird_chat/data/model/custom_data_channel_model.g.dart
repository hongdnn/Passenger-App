// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_data_channel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomDataChannelModel _$CustomDataChannelModelFromJson(
        Map<String, dynamic> json) =>
    CustomDataChannelModel(
      userIds:
          (json['userIds'] as List<dynamic>?)?.map((e) => e as String).toList(),
      priority: json['priority'] as int?,
      userIdNeedPriority: (json['userIdNeedPriority'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CustomDataChannelModelToJson(
        CustomDataChannelModel instance) =>
    <String, dynamic>{
      'userIds': instance.userIds,
      'priority': instance.priority,
      'userIdNeedPriority': instance.userIdNeedPriority,
    };
