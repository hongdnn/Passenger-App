import 'package:json_annotation/json_annotation.dart';
part 'price_by_cartype_model.g.dart';

@JsonSerializable()
class PriceByCarTypeModel {
  factory PriceByCarTypeModel.fromJson(Map<String, dynamic> json) =>
      _$PriceByCarTypeModelFromJson(json);
  PriceByCarTypeModel({
    this.resultCode,
    this.errorMessage,
    this.data,
  });

  @JsonKey(name: 'resultCode')
  int? resultCode;

  @JsonKey(name: 'errorMessage')
  String? errorMessage;

  @JsonKey(name: 'data')
  List<PriceByCarTypeData>? data;

  Map<String, dynamic> toJson() => _$PriceByCarTypeModelToJson(this);
}

@JsonSerializable()
class PriceByCarTypeData {
  factory PriceByCarTypeData.fromJson(Map<String, dynamic> json) =>
      _$PriceByCarTypeDataFromJson(json);
  PriceByCarTypeData({
    this.category,
    this.cars,
  });

  @JsonKey(name: 'category')
  String? category;

  @JsonKey(name: 'cars')
  List<CarInfoByPrice>? cars;

  Map<String, dynamic> toJson() => _$PriceByCarTypeDataToJson(this);
}

@JsonSerializable()
class CarInfoByPrice {
  factory CarInfoByPrice.fromJson(Map<String, dynamic> json) =>
      _$CarInfoByPriceFromJson(json);
  CarInfoByPrice({
    this.driverTypeId,
    this.typeName,
    this.typeSlogan,
    this.carImage,
    this.carIcon,
    this.longitude,
    this.latitude,
    this.price,
    this.orders,
    this.category,
    this.demandRate,
  });

  @JsonKey(name: 'driverTypeId')
  int? driverTypeId;

  @JsonKey(name: 'typeName')
  String? typeName;

  @JsonKey(name: 'typeSlogan')
  String? typeSlogan;

  @JsonKey(name: 'carImage')
  String? carImage;

  @JsonKey(name: 'carIcon')
  String? carIcon;

  @JsonKey(name: 'longitude')
  double? longitude;

  @JsonKey(name: 'latitude')
  double? latitude;

  @JsonKey(name: 'price')
  double? price;

  @JsonKey(name: 'orders')
  int? orders;

  @JsonKey(name: 'category')
  String? category;
  
  @JsonKey(name: 'demandRate')
  double? demandRate;

  Map<String, dynamic> toJson() => _$CarInfoByPriceToJson(this);
}

@JsonSerializable()
class GetPriceRequestBody {
  factory GetPriceRequestBody.fromJson(Map<String, dynamic> json) =>
      _$GetPriceRequestBodyFromJson(json);
  GetPriceRequestBody({
    this.depLat,
    this.depLng,
    this.desLat,
    this.desLng,
    this.distance,
  });

  @JsonKey(name: 'dep_lat')
  double? depLat;

  @JsonKey(name: 'dep_lng')
  double? depLng;

  @JsonKey(name: 'des_lat')
  double? desLat;

  @JsonKey(name: 'des_lng')
  double? desLng;

  @JsonKey(name: 'distance')
  int? distance;

  Map<String, dynamic> toJson() => _$GetPriceRequestBodyToJson(this);
}
