import 'package:json_annotation/json_annotation.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
part 'confirm_pickup_passenger_model.g.dart';

@JsonSerializable()
class ConfirmPickupPassengerModel {
  factory ConfirmPickupPassengerModel.fromJson(Map<String, dynamic> json) =>
      _$ConfirmPickupPassengerModelFromJson(json);
  ConfirmPickupPassengerModel({
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

  Map<String, dynamic> toJson() => _$ConfirmPickupPassengerModelToJson(this);
}

@JsonSerializable()
class ConfirmPickupPassengerRequestBody {
  factory ConfirmPickupPassengerRequestBody.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ConfirmPickupPassengerRequestBodyFromJson(json);
  ConfirmPickupPassengerRequestBody({
    this.bookingId,
    this.longitude,
    this.latitude,
  });

  @JsonKey(name: 'booking_id')
  String? bookingId;

  @JsonKey(name: 'longitude')
  double? longitude;

  @JsonKey(name: 'latitude')
  double? latitude;

  Map<String, dynamic> toJson() =>
      _$ConfirmPickupPassengerRequestBodyToJson(this);
}
