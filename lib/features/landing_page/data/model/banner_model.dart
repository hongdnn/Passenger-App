import 'package:json_annotation/json_annotation.dart';

part 'banner_model.g.dart';

@JsonSerializable()
class BannerResponse{
  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);

  BannerResponse({this.status, this.errorMessage, this.data});
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'errorMessage')
  String? errorMessage;
  @JsonKey(name: 'data')
  List<BannerDetail>? data;
  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);

}

@JsonSerializable()
class BannerDetail{
  factory BannerDetail.fromJson(Map<String, dynamic> json) =>
      _$BannerDetailFromJson(json);

  BannerDetail({this.url});
  @JsonKey(name: 'url')
  String? url;
  Map<String, dynamic> toJson() => _$BannerDetailToJson(this);

}