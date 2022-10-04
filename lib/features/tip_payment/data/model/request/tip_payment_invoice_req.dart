import 'package:json_annotation/json_annotation.dart';

part 'tip_payment_invoice_req.g.dart';

@JsonSerializable()
class TipPaymentInvoiceRequest {
  factory TipPaymentInvoiceRequest.fromJson(Map<String, dynamic> json) =>
      _$TipPaymentInvoiceRequestFromJson(json);
  TipPaymentInvoiceRequest({
    this.bookingId,
    this.paymentMethodId,
    this.userId,
  });
  String? paymentMethodId;
  String? bookingId;
  String? userId;

  TipPaymentInvoiceRequest copyWith({
    String? bookingIdParam,
    String? paymentMethodIdParam,
    String? userIdParam,
  }) {
    bookingId = bookingIdParam ?? bookingId;
    paymentMethodId = paymentMethodIdParam ?? paymentMethodId;
    userId = userIdParam ?? userId;

    return this;
  }

  Map<String, dynamic> toJson() => _$TipPaymentInvoiceRequestToJson(this);
}

@JsonSerializable()
class TipPaymentInvoiceProcessRequest {
  TipPaymentInvoiceProcessRequest({
    this.tipInvoiceId,
  });

  factory TipPaymentInvoiceProcessRequest.fromJson(Map<String, dynamic> json) =>
      _$TipPaymentInvoiceProcessRequestFromJson(json);
  String? tipInvoiceId;
  Map<String, dynamic> toJson() =>
      _$TipPaymentInvoiceProcessRequestToJson(this);
}
