import 'package:json_annotation/json_annotation.dart';
part 'update_booking_model.g.dart';

@JsonSerializable()
class UpdateBookingPayloadModel {
  factory UpdateBookingPayloadModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateBookingPayloadModelFromJson(json);
  UpdateBookingPayloadModel({
    this.userId,
    this.paymentMethodId,
  });

  final String? userId;
  final String? paymentMethodId;

  Map<String, dynamic> toJson() => _$UpdateBookingPayloadModelToJson(this);
}
