import 'package:json_annotation/json_annotation.dart';
import 'package:passenger/features/booking_page/data/model/payment_method_model.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';

part 'tip_payment_invoice.g.dart';

@JsonSerializable()
class TipPaymentInvoiceResponse {
  factory TipPaymentInvoiceResponse.fromJson(Map<String, dynamic> json) =>
      _$TipPaymentInvoiceResponseFromJson(json);
  TipPaymentInvoiceResponse({
    this.errorMessage,
    this.status,
    this.data,
  });

  @JsonKey(name: 'errorMessage')
  String? errorMessage;

  @JsonKey(name: 'status')
  int? status;

  @JsonKey(name: 'data')
  TipPaymentInvoice? data;

  Map<String, dynamic> toJson() => _$TipPaymentInvoiceResponseToJson(this);
}

@JsonSerializable()
class TipPaymentInvoice {
  TipPaymentInvoice({
    this.booking,
    this.createdAt,
    this.id,
    this.paymentDate,
    this.paymentMethod,
    this.tipInvoiceStatus,
    this.updatedAt,
    this.userId,
  });

  factory TipPaymentInvoice.fromJson(Map<String, dynamic> json) =>
      _$TipPaymentInvoiceFromJson(json);
  String? userId;
  BookingData? booking;
  PaymentMethodData? paymentMethod;
  String? paymentDate;
  String? id;
  num? tipInvoiceStatus;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() => _$TipPaymentInvoiceToJson(this);
}
