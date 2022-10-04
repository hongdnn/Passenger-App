import 'package:json_annotation/json_annotation.dart';

part 'upsert_fcm_token_model.g.dart';
@JsonSerializable()
class FcmTokenResponse {
  factory FcmTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$FcmTokenResponseFromJson(json);
  FcmTokenResponse({
    this.token,
    this.deviceId,
    this.userId,
  });
  @JsonKey(name: 'token')
  String? token;
  @JsonKey(name: 'deviceId')
  String? deviceId;
  @JsonKey(name: 'userId')
  String? userId;
  Map<String, dynamic> toJson() => _$FcmTokenResponseToJson(this);
}

@JsonSerializable()
class FcmTokenModel {
  factory FcmTokenModel.fromJson(Map<String, dynamic> json) =>
      _$FcmTokenModelFromJson(json);
  FcmTokenModel({
    this.errorMessage,
    this.status,
    this.data,
  });
  @JsonKey(name: 'errorMessage')
  String? errorMessage;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'data')
  Data? data;
  Map<String, dynamic> toJson() => _$FcmTokenModelToJson(this);
}

@JsonSerializable()
class Data {
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Data({
    this.id,
    this.token,
    this.userId,
    this.deviceId,
  });

  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'token')
  String? token;
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(name: 'deviceId')
  String? deviceId;
  Map<String, dynamic> toJson() => _$DataToJson(this);
}
