import 'package:json_annotation/json_annotation.dart';

part 'place_detail_model.g.dart';

@JsonSerializable()
class PlaceDetailModel {
  factory PlaceDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceDetailModelFromJson(json);
  PlaceDetailModel({
    this.htmlAttributions,
    this.result,
    this.status,
  });

  List<dynamic>? htmlAttributions;
  Result? result;
  String? status;
  Map<String, dynamic> toJson() => _$PlaceDetailModelToJson(this);

  double? get getLatitude => result?.geometry?.location?.lat;

  double? get getLongitude => result?.geometry?.location?.lng;
}

@JsonSerializable()
class Result {
  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
  Result({
    this.addressComponents,
    this.adrAddress,
    this.formattedAddress,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.name,
    this.placeId,
    this.plusCode,
    this.reference,
    this.types,
    this.url,
    this.utcOffset,
  });

  List<AddressComponent>? addressComponents;
  String? adrAddress;
  @JsonKey(name: 'formatted_address')
  String? formattedAddress;
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  @JsonKey(name: 'place_id')
  String? placeId;
  PlusCode? plusCode;
  String? reference;
  List<String>? types;
  String? url;
  int? utcOffset;
  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class AddressComponent {
  factory AddressComponent.fromJson(Map<String, dynamic> json) =>
      _$AddressComponentFromJson(json);
  AddressComponent({
    this.longName,
    this.shortName,
    this.types,
  });

  String? longName;
  String? shortName;
  List<String>? types;
  Map<String, dynamic> toJson() => _$AddressComponentToJson(this);
}

@JsonSerializable()
class Geometry {
  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);
  Geometry({
    this.location,
    this.viewport,
  });

  Location? location;
  Viewport? viewport;
  Map<String, dynamic> toJson() => _$GeometryToJson(this);
}

@JsonSerializable()
class Location {
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Location({
    this.lat,
    this.lng,
  });

  double? lat;
  double? lng;
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class Viewport {
  factory Viewport.fromJson(Map<String, dynamic> json) =>
      _$ViewportFromJson(json);
  Viewport({
    this.northeast,
    this.southwest,
  });

  Location? northeast;
  Location? southwest;
  Map<String, dynamic> toJson() => _$ViewportToJson(this);
}

@JsonSerializable()
class PlusCode {
  factory PlusCode.fromJson(Map<String, dynamic> json) =>
      _$PlusCodeFromJson(json);
  PlusCode({
    this.compoundCode,
    this.globalCode,
  });

  String? compoundCode;
  String? globalCode;
  Map<String, dynamic> toJson() => _$PlusCodeToJson(this);
}
