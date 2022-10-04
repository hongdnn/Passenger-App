import 'package:json_annotation/json_annotation.dart';
part 'finish_trip_driver_app_model.g.dart';

@JsonSerializable()
class FinishTripDriverAppResponse {
  FinishTripDriverAppResponse({
    this.driverBookingId,
    this.totalAmount = 0,
    this.expressWayFee = 0,
    this.longitude = 0,
    this.latitude = 0,
  });
  factory FinishTripDriverAppResponse.fromJson(Map<String, dynamic> json) =>
      _$FinishTripDriverAppResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FinishTripDriverAppResponseToJson(this);

  @JsonKey(name: 'driverBookingId')
  String? driverBookingId;
  @JsonKey(name: 'totalAmount')
  int? totalAmount;
  @JsonKey(name: 'expressWayFee')
  int? expressWayFee;
  @JsonKey(name: 'longitude')
  int? longitude;
  @JsonKey(name: 'latitude')
  int? latitude;
}

@JsonSerializable()
class FinishTripDriverAppModel {
  FinishTripDriverAppModel({
    this.errorMessage,
    this.status,
    this.data,
  });
  factory FinishTripDriverAppModel.fromJson(Map<String, dynamic> json) =>
      _$FinishTripDriverAppModelFromJson(json);

  Map<String, dynamic> toJson() => _$FinishTripDriverAppModelToJson(this);
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
