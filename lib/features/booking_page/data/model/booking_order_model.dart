import 'package:json_annotation/json_annotation.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
part 'booking_order_model.g.dart';

@JsonSerializable()
class BookingOrderModel {
  factory BookingOrderModel.fromJson(Map<String, dynamic> json) =>
      _$BookingOrderModelFromJson(json);
  BookingOrderModel({
    this.errorMessage,
    this.status,
    this.data,
  });

  @JsonKey(name: 'errorMessage')
  String? errorMessage;

  @JsonKey(name: 'resultCode')
  int? status;

  @JsonKey(name: 'data')
  BookingData? data;

  Map<String, dynamic> toJson() => _$BookingOrderModelToJson(this);
}

@JsonSerializable()
class ConfirmBookingRequestModel {
  factory ConfirmBookingRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ConfirmBookingRequestModelFromJson(json);
  ConfirmBookingRequestModel({
    this.userId,
    this.tripId,
    this.paymentMethodId,
    this.promotion,
  });

  @JsonKey(name: 'userId')
  String? userId;

  @JsonKey(name: 'tripId')
  String? tripId;

  @JsonKey(name: 'paymentMethodId')
  String? paymentMethodId;

  @JsonKey(name: 'promotion')
  Promotion? promotion;

  Map<String, dynamic> toJson() => _$ConfirmBookingRequestModelToJson(this);
}

@JsonSerializable()
class Promotion {
  factory Promotion.fromJson(Map<String, dynamic> json) =>
      _$PromotionFromJson(json);

  Promotion({
    this.promotionId,
    this.promotionCode,
    this.voucherCode,
  });

  int? promotionId;
  String? promotionCode;
  String? voucherCode;

  Map<String, dynamic> toJson() => _$PromotionToJson(this);
}
