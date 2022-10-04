import 'package:json_annotation/json_annotation.dart';
part 'check_booking_availability_model.g.dart';

@JsonSerializable()
class CheckBookingAvailabilityModel {
  factory CheckBookingAvailabilityModel.fromJson(Map<String, dynamic> json) =>
      _$CheckBookingAvailabilityModelFromJson(json);
  CheckBookingAvailabilityModel({
    this.errorMessage,
    this.status,
    this.data,
  });
  @JsonKey(name: 'errorMessage')
  String? errorMessage;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'data')
  DataCheckBookingAvailability? data;
  Map<String, dynamic> toJson() => _$CheckBookingAvailabilityModelToJson(this);
}

@JsonSerializable()
class DataCheckBookingAvailability {
  factory DataCheckBookingAvailability.fromJson(Map<String, dynamic> json) =>
      _$DataCheckBookingAvailabilityFromJson(json);
  DataCheckBookingAvailability({
    this.isAvailable,
    this.booking,
  });
  @JsonKey(name: 'isAvailable')
  bool? isAvailable;

  @JsonKey(name: 'booking')
  Booking? booking;
  Map<String, dynamic> toJson() => _$DataCheckBookingAvailabilityToJson(this);
}

@JsonSerializable()
class Booking {
  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);
  Booking({
    this.id,
  });
  @JsonKey(name: 'id')
  String? id;

  Map<String, dynamic> toJson() => _$BookingToJson(this);
}
