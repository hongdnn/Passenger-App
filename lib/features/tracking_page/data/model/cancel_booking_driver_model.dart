import 'package:json_annotation/json_annotation.dart';
part 'cancel_booking_driver_model.g.dart';
@JsonSerializable()
class CanceBookingDriverResponse {
  CanceBookingDriverResponse({
    this.driverBookingId,
    this.cancelReason = 'cancelReason',
    this.longitude = 0,
    this.latitude = 0,
  });
  factory CanceBookingDriverResponse.fromJson(Map<String, dynamic> json) =>
      _$CanceBookingDriverResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CanceBookingDriverResponseToJson(this);

  @JsonKey(name: 'driverBookingId')
  String? driverBookingId;
  @JsonKey(name: 'cancelReason')
  String? cancelReason;
  @JsonKey(name: 'longitude')
  int? longitude;
  @JsonKey(name: 'latitude')
  int? latitude;
}

@JsonSerializable()
class CanceBookingDriverModel {
  CanceBookingDriverModel({
    this.errorMessage,
    this.status,
    this.data,
  });
  factory CanceBookingDriverModel.fromJson(Map<String, dynamic> json) =>
      _$CanceBookingDriverModelFromJson(json);

  Map<String, dynamic> toJson() => _$CanceBookingDriverModelToJson(this);
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
