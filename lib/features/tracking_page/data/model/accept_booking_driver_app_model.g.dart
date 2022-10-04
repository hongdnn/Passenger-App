// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accept_booking_driver_app_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcceptBookingDriverAppModel _$AcceptBookingDriverAppModelFromJson(
        Map<String, dynamic> json) =>
    AcceptBookingDriverAppModel(
      errorMessage: json['errorMessage'] as String?,
      status: json['status'] as int?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AcceptBookingDriverAppModelToJson(
        AcceptBookingDriverAppModel instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'status': instance.status,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data();

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{};

AcceptBookingDriverAppResponse _$AcceptBookingDriverAppResponseFromJson(
        Map<String, dynamic> json) =>
    AcceptBookingDriverAppResponse(
      driverBookingId: json['driverBookingId'] as String?,
      firestoreDriverId: json['firestoreDriverId'] as String? ?? 'string',
      driverToPickupDistance: json['driverToPickupDistance'] as int? ?? 12,
      driverToPickupTakeTime: json['driverToPickupTakeTime'] as int? ?? 25,
      carInfo: json['carInfo'] == null
          ? null
          : CarInfo.fromJson(json['carInfo'] as Map<String, dynamic>),
      driverInfo: json['driverInfo'] == null
          ? null
          : DriverInfo.fromJson(json['driverInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AcceptBookingDriverAppResponseToJson(
        AcceptBookingDriverAppResponse instance) =>
    <String, dynamic>{
      'driverBookingId': instance.driverBookingId,
      'firestoreDriverId': instance.firestoreDriverId,
      'driverToPickupDistance': instance.driverToPickupDistance,
      'driverToPickupTakeTime': instance.driverToPickupTakeTime,
      'carInfo': instance.carInfo?.toJson(),
      'driverInfo': instance.driverInfo?.toJson(),
    };

CarInfo _$CarInfoFromJson(Map<String, dynamic> json) => CarInfo(
      carId: json['carId'] as String? ?? 'string',
      carTypeId: json['carTypeId'] as String? ?? '1',
      driverId: json['driverId'] as String? ?? 'string',
      icon: json['icon'] as String? ??
          'https://i.ibb.co/JcSvbzQ/image-2022-07-01-T08-57-48-034-Z.png',
      size: json['size'] as String? ?? 'M',
      licensePlateNumber: json['licensePlateNumber'] as String? ?? '29A-957.54',
      branchName: json['branchName'] as String? ?? 'Vinfast',
      color: json['color'] as String? ?? 'Pink',
      regionRegister: json['regionRegister'] as String? ?? 'Hanoi',
    );

Map<String, dynamic> _$CarInfoToJson(CarInfo instance) => <String, dynamic>{
      'carId': instance.carId,
      'carTypeId': instance.carTypeId,
      'driverId': instance.driverId,
      'icon': instance.icon,
      'size': instance.size,
      'licensePlateNumber': instance.licensePlateNumber,
      'branchName': instance.branchName,
      'color': instance.color,
      'regionRegister': instance.regionRegister,
    };

DriverInfo _$DriverInfoFromJson(Map<String, dynamic> json) => DriverInfo(
      driverId: json['driverId'] as String? ?? 'string',
      name: json['name'] as String? ?? 'Peter Parker',
      avatar: json['avatar'] as String? ??
          'https://i.ibb.co/7YK1Nkr/image-2022-07-06-T03-44-13-236-Z.png',
      phoneNumber: json['phoneNumber'] as String? ?? '0377256985',
      rating: (json['rating'] as num?)?.toDouble() ?? 4.8,
      longitude: json['longitude'] as int? ?? 0,
      latitude: json['latitude'] as int? ?? 0,
    );

Map<String, dynamic> _$DriverInfoToJson(DriverInfo instance) =>
    <String, dynamic>{
      'driverId': instance.driverId,
      'name': instance.name,
      'avatar': instance.avatar,
      'phoneNumber': instance.phoneNumber,
      'rating': instance.rating,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };
