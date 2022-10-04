import 'package:json_annotation/json_annotation.dart';
part 'check_booking_availability_model.g.dart';

@JsonSerializable()
class CheckBookingAvailabilityModel {

  factory CheckBookingAvailabilityModel.fromJson(Map<String, dynamic> json) =>
      _$CheckBookingAvailabilityModelFromJson(json);
  CheckBookingAvailabilityModel({
    this.errorMessage,
    this.resultCode,
    this.data,
  });

  @JsonKey(name: 'errorMessage')
  String? errorMessage;

  @JsonKey(name: 'resultCode')
  int? resultCode;

  @JsonKey(name: 'data')
  CheckBookingAvailabilityData? data;

  Map<String, dynamic> toJson() => _$CheckBookingAvailabilityModelToJson(this);
}

@JsonSerializable()
class CheckBookingAvailabilityData {

  factory CheckBookingAvailabilityData.fromJson(Map<String, dynamic> json) =>
      _$CheckBookingAvailabilityDataFromJson(json);
  CheckBookingAvailabilityData({
    this.isAvailable,
    this.bookingId,
  });

  @JsonKey(name: 'isAvailable')
  bool? isAvailable;

  @JsonKey(name: 'bookingId')
  String? bookingId;

  @JsonKey(name: 'lockTo')
  String? lockTo;

  Map<String, dynamic> toJson() => _$CheckBookingAvailabilityDataToJson(this);
}

