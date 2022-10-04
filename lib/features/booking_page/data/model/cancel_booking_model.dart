import 'package:json_annotation/json_annotation.dart';
part 'cancel_booking_model.g.dart';

@JsonSerializable()
class CancelBookingModel {
  factory CancelBookingModel.fromJson(Map<String, dynamic> json) =>
      _$CancelBookingModelFromJson(json);
  CancelBookingModel({
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
  Map<String, dynamic> toJson() => _$CancelBookingModelToJson(this);
}

@JsonSerializable()
class Data {
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Data({
    this.cancelTimes,
  });
  @JsonKey(name: 'cancelTimes')
  int? cancelTimes;
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class CancelBookingBody {
  factory CancelBookingBody.fromJson(Map<String, dynamic> json) =>
      _$CancelBookingBodyFromJson(json);
  CancelBookingBody({
    this.id,
    this.cancelReason,
    this.userId,
  });
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'cancelReason')
  String? cancelReason;
  @JsonKey(name: 'userId')
  String? userId;
  Map<String, dynamic> toJson() => _$CancelBookingBodyToJson(this);
}
