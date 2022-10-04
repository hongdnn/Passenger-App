import 'package:json_annotation/json_annotation.dart';
part 'payment_type_model.g.dart';

@JsonSerializable()
class PaymentTypeModel {
  factory PaymentTypeModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentTypeModelFromJson(json);
  PaymentTypeModel({
    this.errorMessage,
    this.status,
    this.data,
  });

  final String? errorMessage;
  final int? status;
  final List<PaymentType>? data;

  Map<String, dynamic> toJson() => _$PaymentTypeModelToJson(this);
}

@JsonSerializable()
class PaymentType {
  factory PaymentType.fromJson(Map<String, dynamic> json) =>
      _$PaymentTypeFromJson(json);
  PaymentType({
    this.id,
    this.name,
    this.icon,
    this.isCard,
  });

  final String? id;
  final String? name;
  final String? icon;
  final bool? isCard;

  Map<String, dynamic> toJson() => _$PaymentTypeToJson(this);
}
