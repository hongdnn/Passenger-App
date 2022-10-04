import 'package:json_annotation/json_annotation.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
part 'finish_trip_model.g.dart';

@JsonSerializable()
class FinishTripModel {
  factory FinishTripModel.fromJson(Map<String, dynamic> json) =>
      _$FinishTripModelFromJson(json);
  FinishTripModel({
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

  Map<String, dynamic> toJson() => _$FinishTripModelToJson(this);
}

@JsonSerializable()
class FinishTripRequestBody {
  factory FinishTripRequestBody.fromJson(Map<String, dynamic> json) =>
      _$FinishTripRequestBodyFromJson(json);
  FinishTripRequestBody({
    this.bookingId,
    this.waitingFreeNote,
    this.waitingFreeAmount,
    this.longitude,
    this.latitude,
  });

  @JsonKey(name: 'booking_id')
  String? bookingId;

  @JsonKey(name: 'waiting_free_note')
  String? waitingFreeNote;

  @JsonKey(name: 'waiting_free_amount')
  int? waitingFreeAmount;

  @JsonKey(name: 'longitude')
  double? longitude;

  @JsonKey(name: 'latitude')
  double? latitude;

  Map<String, dynamic> toJson() => _$FinishTripRequestBodyToJson(this);
}
