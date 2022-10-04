import 'package:json_annotation/json_annotation.dart';
import 'package:passenger/features/booking_page/data/model/payment_method_model.dart';
part 'payment_items_model.g.dart';

@JsonSerializable()
class PaymentItemsModel {
  factory PaymentItemsModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentItemsModelFromJson(json);
  PaymentItemsModel({
    this.errorMessage,
    this.status,
    this.data,
  });

  final String? errorMessage;
  final int? status;
  final List<PaymentMethodData>? data;

  Map<String, dynamic> toJson() => _$PaymentItemsModelToJson(this);
}
