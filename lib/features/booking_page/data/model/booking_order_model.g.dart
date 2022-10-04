// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingOrderModel _$BookingOrderModelFromJson(Map<String, dynamic> json) =>
    BookingOrderModel(
      errorMessage: json['errorMessage'] as String?,
      status: json['resultCode'] as int?,
      data: json['data'] == null
          ? null
          : BookingData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingOrderModelToJson(BookingOrderModel instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'resultCode': instance.status,
      'data': instance.data,
    };

ConfirmBookingRequestModel _$ConfirmBookingRequestModelFromJson(
        Map<String, dynamic> json) =>
    ConfirmBookingRequestModel(
      userId: json['userId'] as String?,
      tripId: json['tripId'] as String?,
      paymentMethodId: json['paymentMethodId'] as String?,
      promotion: json['promotion'] == null
          ? null
          : Promotion.fromJson(json['promotion'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConfirmBookingRequestModelToJson(
        ConfirmBookingRequestModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'tripId': instance.tripId,
      'paymentMethodId': instance.paymentMethodId,
      'promotion': instance.promotion,
    };

Promotion _$PromotionFromJson(Map<String, dynamic> json) => Promotion(
      promotionId: json['promotionId'] as int?,
      promotionCode: json['promotionCode'] as String?,
      voucherCode: json['voucherCode'] as String?,
    );

Map<String, dynamic> _$PromotionToJson(Promotion instance) => <String, dynamic>{
      'promotionId': instance.promotionId,
      'promotionCode': instance.promotionCode,
      'voucherCode': instance.voucherCode,
    };
