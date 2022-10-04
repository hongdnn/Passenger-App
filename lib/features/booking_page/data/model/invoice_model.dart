import 'package:json_annotation/json_annotation.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';

part 'invoice_model.g.dart';

@JsonSerializable()
class InvoiceModel {
  factory InvoiceModel.fromJson(Map<String, dynamic> json) =>
      _$InvoiceModelFromJson(json);
  InvoiceModel({
    this.errorMessage,
    this.status,
    this.data,
  });

  @JsonKey(name: 'errorMessage')
  String? errorMessage;

  @JsonKey(name: 'status')
  int? status;

  @JsonKey(name: 'data')
  InvoiceData? data;

  Map<String, dynamic> toJson() => _$InvoiceModelToJson(this);
}

@JsonSerializable()
class InvoiceData {
  factory InvoiceData.fromJson(Map<String, dynamic> json) =>
      _$InvoiceDataFromJson(json);
  InvoiceData({
    this.id,
    this.userId,
    this.amount,
    this.invoiceStatus,
    this.note,
    this.resultId,
    this.resultContent,
    this.paymentDate,
    this.createdAt,
    this.updatedAt,
    this.booking,
  });

  String? id;
  String? userId;
  double? amount;
  int? invoiceStatus;
  String? note;
  String? resultId;
  String? resultContent;
  String? paymentDate;
  String? createdAt;
  String? updatedAt;
  BookingData? booking;

  Map<String, dynamic> toJson() => _$InvoiceDataToJson(this);
}

@JsonSerializable()
class InvoiceRequestBody {
  factory InvoiceRequestBody.fromJson(Map<String, dynamic> json) =>
      _$InvoiceRequestBodyFromJson(json);
  InvoiceRequestBody({
    this.userId,
    this.bookingId,
    this.amount,
    this.note,
  });

  @JsonKey(name: 'userId')
  String? userId;

  @JsonKey(name: 'bookingId')
  String? bookingId;

  @JsonKey(name: 'amount')
  double? amount;

  @JsonKey(name: 'note')
  String? note;

  Map<String, dynamic> toJson() => _$InvoiceRequestBodyToJson(this);
}
