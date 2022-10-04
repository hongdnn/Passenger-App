// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceModel _$InvoiceModelFromJson(Map<String, dynamic> json) => InvoiceModel(
      errorMessage: json['errorMessage'] as String?,
      status: json['status'] as int?,
      data: json['data'] == null
          ? null
          : InvoiceData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InvoiceModelToJson(InvoiceModel instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'status': instance.status,
      'data': instance.data,
    };

InvoiceData _$InvoiceDataFromJson(Map<String, dynamic> json) => InvoiceData(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      invoiceStatus: json['invoiceStatus'] as int?,
      note: json['note'] as String?,
      resultId: json['resultId'] as String?,
      resultContent: json['resultContent'] as String?,
      paymentDate: json['paymentDate'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      booking: json['booking'] == null
          ? null
          : BookingData.fromJson(json['booking'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InvoiceDataToJson(InvoiceData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'amount': instance.amount,
      'invoiceStatus': instance.invoiceStatus,
      'note': instance.note,
      'resultId': instance.resultId,
      'resultContent': instance.resultContent,
      'paymentDate': instance.paymentDate,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'booking': instance.booking,
    };

InvoiceRequestBody _$InvoiceRequestBodyFromJson(Map<String, dynamic> json) =>
    InvoiceRequestBody(
      userId: json['userId'] as String?,
      bookingId: json['bookingId'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$InvoiceRequestBodyToJson(InvoiceRequestBody instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'bookingId': instance.bookingId,
      'amount': instance.amount,
      'note': instance.note,
    };
