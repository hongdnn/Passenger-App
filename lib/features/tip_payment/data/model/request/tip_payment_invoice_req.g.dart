// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip_payment_invoice_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TipPaymentInvoiceRequest _$TipPaymentInvoiceRequestFromJson(
        Map<String, dynamic> json) =>
    TipPaymentInvoiceRequest(
      bookingId: json['bookingId'] as String?,
      paymentMethodId: json['paymentMethodId'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$TipPaymentInvoiceRequestToJson(
        TipPaymentInvoiceRequest instance) =>
    <String, dynamic>{
      'paymentMethodId': instance.paymentMethodId,
      'bookingId': instance.bookingId,
      'userId': instance.userId,
    };

TipPaymentInvoiceProcessRequest _$TipPaymentInvoiceProcessRequestFromJson(
        Map<String, dynamic> json) =>
    TipPaymentInvoiceProcessRequest(
      tipInvoiceId: json['tipInvoiceId'] as String?,
    );

Map<String, dynamic> _$TipPaymentInvoiceProcessRequestToJson(
        TipPaymentInvoiceProcessRequest instance) =>
    <String, dynamic>{
      'tipInvoiceId': instance.tipInvoiceId,
    };
