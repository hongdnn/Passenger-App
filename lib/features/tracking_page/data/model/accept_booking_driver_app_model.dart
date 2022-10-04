import 'package:json_annotation/json_annotation.dart';
part 'accept_booking_driver_app_model.g.dart';

@JsonSerializable()
class AcceptBookingDriverAppModel {
  factory AcceptBookingDriverAppModel.fromJson(Map<String, dynamic> json) =>
      _$AcceptBookingDriverAppModelFromJson(json);
  AcceptBookingDriverAppModel({
    this.errorMessage,
    this.status,
    this.data,
  });
  @JsonKey(name: 'errorMessage')
  String? errorMessage;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'data')
  Data? data;
  Map<String, dynamic> toJson() => _$AcceptBookingDriverAppModelToJson(this);
}

@JsonSerializable()
class Data {
  Data();
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AcceptBookingDriverAppResponse {
  AcceptBookingDriverAppResponse({
    this.driverBookingId,
    this.firestoreDriverId = 'string',
    this.driverToPickupDistance = 12,
    this.driverToPickupTakeTime = 25,
    this.carInfo,
    this.driverInfo,
  });
  factory AcceptBookingDriverAppResponse.fromJson(Map<String, dynamic> json) =>
      _$AcceptBookingDriverAppResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptBookingDriverAppResponseToJson(this);
  @JsonKey(name: 'driverBookingId')
  String? driverBookingId;
  @JsonKey(name: 'firestoreDriverId')
  String? firestoreDriverId;
  @JsonKey(name: 'driverToPickupDistance')
  int? driverToPickupDistance;
  @JsonKey(name: 'driverToPickupTakeTime')
  int? driverToPickupTakeTime;
  @JsonKey(name: 'carInfo')
  CarInfo? carInfo;
  @JsonKey(name: 'driverInfo')
  DriverInfo? driverInfo;
}

@JsonSerializable(explicitToJson: true)
class CarInfo {
  CarInfo({
    this.carId = 'string',
    this.carTypeId = '1',
    this.driverId = 'string',
    this.icon = 'https://i.ibb.co/JcSvbzQ/image-2022-07-01-T08-57-48-034-Z.png',
    this.size = 'M',
    this.licensePlateNumber = '29A-957.54',
    this.branchName = 'Vinfast',
    this.color = 'Pink',
    this.regionRegister = 'Hanoi',
  });
  factory CarInfo.fromJson(Map<String, dynamic> json) =>
      _$CarInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CarInfoToJson(this);
  @JsonKey(name: 'carId')
  String? carId;
  @JsonKey(name: 'carTypeId')
  String? carTypeId;
  @JsonKey(name: 'driverId')
  String? driverId;
  @JsonKey(name: 'icon')
  String? icon =
      'https://i.ibb.co/JcSvbzQ/image-2022-07-01-T08-57-48-034-Z.png';
  @JsonKey(name: 'size')
  String? size;
  @JsonKey(name: 'licensePlateNumber')
  String? licensePlateNumber;
  @JsonKey(name: 'branchName')
  String? branchName;
  @JsonKey(name: 'color')
  String? color;
  @JsonKey(name: 'regionRegister')
  String? regionRegister;
}

@JsonSerializable(explicitToJson: true)
class DriverInfo {
  DriverInfo({
    this.driverId = 'string',
    this.name = 'Peter Parker',
    this.avatar =
        'https://i.ibb.co/7YK1Nkr/image-2022-07-06-T03-44-13-236-Z.png',
    this.phoneNumber = '0377256985',
    this.rating = 4.8,
    this.longitude = 0,
    this.latitude = 0,
  });
  factory DriverInfo.fromJson(Map<String, dynamic> json) =>
      _$DriverInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DriverInfoToJson(this);
  @JsonKey(name: 'driverId')
  String? driverId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'avatar')
  String? avatar;
  @JsonKey(name: 'phoneNumber')
  String? phoneNumber;
  @JsonKey(name: 'rating')
  double? rating;
  @JsonKey(name: 'longitude')
  int? longitude;
  @JsonKey(name: 'latitude')
  int? latitude;
}
