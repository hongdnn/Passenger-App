import 'package:json_annotation/json_annotation.dart';
part 'almost_arrive_driver_app_model.g.dart';

@JsonSerializable()
class AlmostArriveDriverAppModel {
  AlmostArriveDriverAppModel({
    this.errorMessage,
    this.status,
    this.data,
  });
  factory AlmostArriveDriverAppModel.fromJson(Map<String, dynamic> json) =>
      _$AlmostArriveDriverAppModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlmostArriveDriverAppModelToJson(this);
  @JsonKey(name: 'errorMessage')
  String? errorMessage;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'data')
  Data? data;
}

@JsonSerializable()
class Data {
  Data();
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
