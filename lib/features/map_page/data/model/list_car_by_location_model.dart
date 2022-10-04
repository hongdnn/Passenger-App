import 'package:json_annotation/json_annotation.dart';
part 'list_car_by_location_model.g.dart';

@JsonSerializable()
class ListCarByLocationModel {
  ListCarByLocationModel({
    required this.status,
    required this.errorMessage,
    required this.data,
  });

  factory ListCarByLocationModel.fromJson(Map<String, dynamic> json) =>
      _$ListCarByLocationModelFromJson(json);

  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'errorMessage')
  String? errorMessage;
  @JsonKey(name: 'data')
  List<CarItem>? data;

  Map<String, dynamic> toJson() => _$ListCarByLocationModelToJson(this);
}

@JsonSerializable()
class CarItem {

  factory CarItem.fromJson(Map<String, dynamic> json) =>
      _$CarItemFromJson(json);
  CarItem({
    required this.typeName,
    required this.carIcon,
    required this.longitude,
    required this.latitude,
  });
  @JsonKey(name: 'typeName')
  final String? typeName;
  @JsonKey(name: 'carIcon')
  final String? carIcon;
  @JsonKey(name: 'longitude')
  final double? longitude;
  @JsonKey(name: 'latitude')
  final double? latitude;

  @JsonKey(name: 'length')
  int? length;
  @JsonKey(name: 'offset')
  int? offset;

  Map<String, dynamic> toJson() => _$CarItemToJson(this);
}
