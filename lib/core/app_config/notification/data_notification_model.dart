import 'package:json_annotation/json_annotation.dart';
part 'data_notification_model.g.dart';

@JsonSerializable()
class DataNotificationModel {
  factory DataNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$DataNotificationModelFromJson(json);
  DataNotificationModel({
    this.actionCode,
    this.userId,
    this.deviceId,
    this.bookingId,
    this.destinationNo,
    this.longitude,
    this.latitude,
    this.bookingStatus,
  });
  @JsonKey(name: 'action_code')
  String? actionCode;
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'device_id')
  String? deviceId;
  @JsonKey(name: 'booking_id')
  String? bookingId;
  @JsonKey(name: 'destination_no')
  String? destinationNo;
  @JsonKey(name: 'longitude')
  String? longitude;
  @JsonKey(name: 'latitude')
  String? latitude;
  @JsonKey(name: 'bookingStatus')
  String? bookingStatus;

  Map<String, dynamic> toJson() => _$DataNotificationModelToJson(this);
}
