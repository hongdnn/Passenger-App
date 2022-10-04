import 'package:json_annotation/json_annotation.dart';

part 'favorite_location.g.dart';

@JsonSerializable()
class FavoriteLocationResponse {
  factory FavoriteLocationResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoriteLocationResponseFromJson(json);

  FavoriteLocationResponse({this.status, this.errorMessage, this.data});
  @JsonKey(name: 'status')
  int? status;

  @JsonKey(name: 'errorMessage')
  String? errorMessage;

  @JsonKey(name: 'data')
  FavoriteLocation? data;

  Map<String, dynamic> toJson() => _$FavoriteLocationResponseToJson(this);
}

@JsonSerializable()
class FavoriteLocationListReponse {
  factory FavoriteLocationListReponse.fromJson(Map<String, dynamic> json) =>
      _$FavoriteLocationListReponseFromJson(json);

  FavoriteLocationListReponse({this.status, this.errorMessage, this.data});
  @JsonKey(name: 'status')
  int? status;

  @JsonKey(name: 'errorMessage')
  String? errorMessage;

  @JsonKey(name: 'data')
  List<FavoriteLocation>? data;

  Map<String, dynamic> toJson() => _$FavoriteLocationListReponseToJson(this);
}

@JsonSerializable()
class FavoriteDeleteResponse {
  factory FavoriteDeleteResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoriteDeleteResponseFromJson(json);

  FavoriteDeleteResponse({this.status, this.errorMessage, this.data});
  @JsonKey(name: 'status')
  int? status;

  @JsonKey(name: 'errorMessage')
  String? errorMessage;

  @JsonKey(name: 'data')
  dynamic data;

  Map<String, dynamic> toJson() => _$FavoriteDeleteResponseToJson(this);
}

@JsonSerializable()
class FavoriteLocation {
  FavoriteLocation({
    this.id,
    this.userId,
    this.title,
    this.createAt,
    this.address,
    this.addressName,
    this.note,
    this.updateAt,
    this.latitude,
    this.longitude,
    this.googleId,
    this.referenceId,
  });

  factory FavoriteLocation.fromJson(Map<String, dynamic> json) =>
      _$FavoriteLocationFromJson(json);

  String? id;
  String? userId;
  String? title;
  double? latitude;
  double? longitude;
  String? address;
  String? addressName;
  String? note;
  String? createAt;
  String? updateAt;
  String? referenceId;
  String? googleId;

  Map<String, dynamic> toJson() {
    if (id != null) {
      return toJsonUpdate();
    }
    return toJsonAdd();
  }

  Map<String, dynamic> toJsonAdd() {
    return <String, dynamic>{
      'userId': userId,
      'title': title ?? '',
      'longitude': longitude,
      'latitude': latitude,
      'address': address ?? '',
      'addressName': addressName ?? '',
      'note': note ?? '',
      'googleId': googleId,
      'referenceId': referenceId
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return <String, dynamic>{
      'id': id ?? '',
      'userId': userId,
      'title': title ?? '',
      'longitude': longitude,
      'latitude': latitude,
      'address': address ?? '',
      'addressName': addressName ?? '',
      'note': note ?? '',
      'googleId': googleId,
      'referenceId': referenceId,
    };
  }
}
