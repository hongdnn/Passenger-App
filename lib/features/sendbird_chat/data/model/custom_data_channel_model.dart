import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'custom_data_channel_model.g.dart';

@JsonSerializable()
class CustomDataChannelModel {
  CustomDataChannelModel({
    this.userIds,
    this.priority,
    this.userIdNeedPriority,
  });

  factory CustomDataChannelModel.fromJson(Map<String, dynamic> json) =>
      _$CustomDataChannelModelFromJson(json);

  factory CustomDataChannelModel.fromString(String dataString) =>
      CustomDataChannelModel.fromJson(
        jsonDecode(dataString) as Map<String, dynamic>,
      );

  final List<String>? userIds;
  final int? priority;
  final List<String>? userIdNeedPriority;

  Map<String, dynamic> toJson() => _$CustomDataChannelModelToJson(this);

  CustomDataChannelModel copyWith({
    List<String>? userIds,
    int? priority,
    List<String>? userIdNeedPriority,
  }) {
    return CustomDataChannelModel(
      userIds: userIds ?? this.userIds,
      priority: priority ?? this.priority,
      userIdNeedPriority: userIdNeedPriority ?? this.userIdNeedPriority,
    );
  }
}
