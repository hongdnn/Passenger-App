import 'package:json_annotation/json_annotation.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
part 'driver_accept_booking_model.g.dart';

@JsonSerializable()
class DriverAcceptBookingModel {
 
  factory DriverAcceptBookingModel.fromJson(Map<String, dynamic> json) =>
      _$DriverAcceptBookingModelFromJson(json);
  DriverAcceptBookingModel({
    this.errorMessage,
    this.status,
    this.data,
  });

  @JsonKey(name: 'errorMessage')
  String? errorMessage;

  @JsonKey(name: 'status')
  int? status;

  @JsonKey(name: 'data')
  BookingData? data;

  Map<String, dynamic> toJson() => _$DriverAcceptBookingModelToJson(this);

}

@JsonSerializable()
class DriverAcceptBookingRequestBody {
  factory DriverAcceptBookingRequestBody.fromJson(Map<String, dynamic> json) =>
      _$DriverAcceptBookingRequestBodyFromJson(json);
  DriverAcceptBookingRequestBody({
    this.carInfo,
    this.driverInfo,
    this.driverToPickupDistance,
    this.driverToPickupTakeTime,
  });

  @JsonKey(name: 'carInfo')
  CarInfoRequestBody? carInfo;

  @JsonKey(name: 'driverInfo')
  DriverInfoRequestBody? driverInfo;

  @JsonKey(name: 'driverToPickupDistance')
  double? driverToPickupDistance;

  @JsonKey(name: 'driverToPickupTakeTime')
  int? driverToPickupTakeTime;

  Map<String, dynamic> toJson() => _$DriverAcceptBookingRequestBodyToJson(this);
}

@JsonSerializable()
class CarInfoRequestBody {
  CarInfoRequestBody();

  factory CarInfoRequestBody.fromJson(Map<String, dynamic> json) =>
      _$CarInfoRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CarInfoRequestBodyToJson(this);
}

@JsonSerializable()
class DriverInfoRequestBody {
  factory DriverInfoRequestBody.fromJson(Map<String, dynamic> json) =>
      _$DriverInfoRequestBodyFromJson(json);
  DriverInfoRequestBody({
    this.longitude,
    this.latitude,
  });

  @JsonKey(name: 'longitude')
  double? longitude;

  @JsonKey(name: 'latitude')
  double? latitude;

  Map<String, dynamic> toJson() => _$DriverInfoRequestBodyToJson(this);
}
