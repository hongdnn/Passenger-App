// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip_payment_invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TipPaymentInvoiceResponse _$TipPaymentInvoiceResponseFromJson(
        Map<String, dynamic> json) =>
    TipPaymentInvoiceResponse(
      errorMessage: json['errorMessage'] as String?,
      status: json['status'] as int?,
      data: json['data'] == null
          ? null
          : TipPaymentInvoice.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TipPaymentInvoiceResponseToJson(
        TipPaymentInvoiceResponse instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'status': instance.status,
      'data': instance.data,
    };

TipPaymentInvoice _$TipPaymentInvoiceFromJson(Map<String, dynamic> json) =>
    TipPaymentInvoice(
      booking: json['booking'] == null
          ? null
          : BookingData.fromJson(json['booking'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
      id: json['id'] as String?,
      paymentDate: json['paymentDate'] as String?,
      paymentMethod: json['paymentMethod'] == null
          ? null
          : PaymentMethodData.fromJson(
              json['paymentMethod'] as Map<String, dynamic>),
      tipInvoiceStatus: json['tipInvoiceStatus'] as num?,
      updatedAt: json['updatedAt'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$TipPaymentInvoiceToJson(TipPaymentInvoice instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'booking': instance.booking,
      'paymentMethod': instance.paymentMethod,
      'paymentDate': instance.paymentDate,
      'id': instance.id,
      'tipInvoiceStatus': instance.tipInvoiceStatus,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
