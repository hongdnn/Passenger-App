import 'package:json_annotation/json_annotation.dart';
part 'confirm_pick_up_passenger_driver_app_model.g.dart';

@JsonSerializable()
class ConfirmPickUpPassengerResponse {
  ConfirmPickUpPassengerResponse({
    this.driverBookingId,
    this.longitude = 0,
    this.latitude = 0,
    this.arrivedTime,
  });
  factory ConfirmPickUpPassengerResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmPickUpPassengerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmPickUpPassengerResponseToJson(this);

  @JsonKey(name: 'driverBookingId')
  String? driverBookingId;
  @JsonKey(name: 'longitude')
  int? longitude;
  @JsonKey(name: 'latitude')
  int? latitude;
  @JsonKey(name: 'arrivedTime')
  DateTime? arrivedTime;
}

@JsonSerializable()
class ConfirmPickUpPassengerModel {
  ConfirmPickUpPassengerModel({
    this.errorMessage,
    this.status,
    this.data,
  });
  factory ConfirmPickUpPassengerModel.fromJson(Map<String, dynamic> json) =>
      _$ConfirmPickUpPassengerModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmPickUpPassengerModelToJson(this);
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
