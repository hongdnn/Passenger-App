import 'package:json_annotation/json_annotation.dart';
part 'arrive_to_pick_up_driver_app_model.g.dart';

@JsonSerializable()
class ArrivePickUpToDriverAppModel {
  ArrivePickUpToDriverAppModel({
    this.errorMessage,
    this.status,
    this.data,
  });
  factory ArrivePickUpToDriverAppModel.fromJson(Map<String, dynamic> json) =>
      _$ArrivePickUpToDriverAppModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArrivePickUpToDriverAppModelToJson(this);
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
