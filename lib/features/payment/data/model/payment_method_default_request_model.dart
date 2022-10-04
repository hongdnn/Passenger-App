import 'package:json_annotation/json_annotation.dart';
part 'payment_method_default_request_model.g.dart';

@JsonSerializable()
class PaymentMethodDefaultRequest {
  factory PaymentMethodDefaultRequest.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodDefaultRequestFromJson(json);
  PaymentMethodDefaultRequest({
    this.userId,
    this.paymentTypeId,
  });

  final String? userId;
  final String? paymentTypeId;

  Map<String, dynamic> toJson() => _$PaymentMethodDefaultRequestToJson(this);
}
