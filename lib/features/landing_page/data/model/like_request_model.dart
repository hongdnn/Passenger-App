import 'package:json_annotation/json_annotation.dart';

part 'like_request_model.g.dart';

@JsonSerializable()
class LikeRequestModel {
  LikeRequestModel({this.isLike});

  @JsonKey(name: 'isLike')
  bool? isLike;

  Map<String, dynamic> toJson() => _$LikeRequestModelToJson(this);
}
