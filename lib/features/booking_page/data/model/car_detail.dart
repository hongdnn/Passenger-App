import 'package:json_annotation/json_annotation.dart';
import 'package:passenger/core/app_config/constant.dart';

part 'car_detail.g.dart';

@JsonSerializable()
class CarDescription {
  factory CarDescription.fromJson(Map<String, dynamic> json) =>
      _$CarDescriptionFromJson(json);

  CarDescription({this.resultCode, this.errorMessage, this.data});
  @JsonKey(name: 'resultCode')
  int? resultCode;
  @JsonKey(name: 'errorMessage')
  String? errorMessage;
  @JsonKey(name: 'data')
  List<CarInformation>? data;
  Map<String, dynamic> toJson() => _$CarDescriptionToJson(this);

  int indexOfCurrentCarType(int? typeId) {
    int currentCarTypeId = noChosenCarsInDriverList;
    for (int i = 0; i < (data ?? <CarInformation>[]).length; i++) {
      if (data?[i].typeId == typeId) {
        currentCarTypeId = i;
        break;
      }
    }
    return currentCarTypeId;
  }
}

@JsonSerializable()
class CarBodyRequest {
  CarBodyRequest({
    this.carTypeIds,
  });

  factory CarBodyRequest.fromJson(Map<String, dynamic> json) =>
      _$CarBodyRequestFromJson(json);

  @JsonKey(name: 'carTypeIds')
  List<String>? carTypeIds;

  Map<String, dynamic> toJson() => _$CarBodyRequestToJson(this);
}

@JsonSerializable()
class CarInformation {
  factory CarInformation.fromJson(Map<String, dynamic> json) =>
      _$CarInformationFromJson(json);
  CarInformation({
    this.typeId,
    this.typeName,
    this.typeSlogan,
    this.typeDescription,
    this.carImage,
    this.carIcon,
    this.longitude,
    this.latitude,
    this.price,
    this.orders,
    this.category,
    this.categoryId,
    this.listPrice,
  });

  @JsonKey(name: 'type_id')
  int? typeId;
  @JsonKey(name: 'type_name')
  String? typeName;
  @JsonKey(name: 'type_slogan')
  String? typeSlogan;
  @JsonKey(name: 'type_description')
  String? typeDescription;
  @JsonKey(name: 'car_image')
  String? carImage;
  @JsonKey(name: 'car_icon')
  String? carIcon;
  @JsonKey(name: 'longitude')
  String? longitude;
  @JsonKey(name: 'latitude')
  String? latitude;
  @JsonKey(name: 'price')
  double? price;
  @JsonKey(name: 'orders')
  int? orders;
  @JsonKey(name: 'category')
  String? category;
  @JsonKey(name: 'category_id')
  int? categoryId;
  @JsonKey(name: 'list_price')
  List<ListPrice>? listPrice;
  Map<String, dynamic> toJson() => _$CarInformationToJson(this);
}

@JsonSerializable()
class ListPrice {
  factory ListPrice.fromJson(Map<String, dynamic> json) =>
      _$ListPriceFromJson(json);

  ListPrice({
    this.label,
    this.minDistance,
    this.maxDistance,
    this.price,
    this.currency,
    this.orders,
    this.typeId,
  });

  @JsonKey(name: 'label')
  int? label;
  @JsonKey(name: 'min_distance')
  int? minDistance;
  @JsonKey(name: 'max_distance')
  int? maxDistance;
  @JsonKey(name: 'price')
  num? price;
  @JsonKey(name: 'currency')
  String? currency;
  @JsonKey(name: 'orders')
  int? orders;
  @JsonKey(name: 'type_id')
  int? typeId;
  Map<String, dynamic> toJson() => _$ListPriceToJson(this);
}
