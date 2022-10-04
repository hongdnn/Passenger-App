import 'package:json_annotation/json_annotation.dart';
import 'package:passenger/features/payment/data/model/payment_type_model.dart';
part 'payment_method_model.g.dart';

@JsonSerializable()
class PaymentMethodModel {
  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodModelFromJson(json);
  PaymentMethodModel({
    this.errorMessage,
    this.status,
    this.data,
  });

  @JsonKey(name: 'errorMessage')
  String? errorMessage;

  @JsonKey(name: 'status')
  int? status;

  @JsonKey(name: 'data')
  PaymentMethodData? data;

  Map<String, dynamic> toJson() => _$PaymentMethodModelToJson(this);
}

@JsonSerializable()
class PaymentMethodData {
  factory PaymentMethodData.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodDataFromJson(json);
  PaymentMethodData({
    this.userId,
    this.name,
    this.icon,
    this.note,
    this.status,
    this.order,
    this.isDefault,
    this.paymentType,
    this.nickname,
    this.id,
    this.createAt,
    this.updateAt,
    this.cardLastDigits,
    this.paymentIcon,
  });

  @JsonKey(name: 'userId')
  String? userId;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'icon')
  String? icon;

  @JsonKey(name: 'note')
  String? note;

  @JsonKey(name: 'status')
  int? status;

  @JsonKey(name: 'order')
  int? order;

  @JsonKey(name: 'isDefault')
  dynamic isDefault;

  @JsonKey(name: 'paymentType')
  PaymentType? paymentType;

  @JsonKey(name: 'nickname')
  String? nickname;

  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'createAt')
  String? createAt;

  @JsonKey(name: 'updateAt')
  String? updateAt;

  @JsonKey(name: 'cardLastDigits')
  String? cardLastDigits;

    @JsonKey(name: 'paymentIcon')
  String? paymentIcon;

  Map<String, dynamic> toJson() => _$PaymentMethodDataToJson(this);
}

@JsonSerializable()
class PaymentRequestBody {
  factory PaymentRequestBody.fromJson(Map<String, dynamic> json) =>
      _$PaymentRequestBodyFromJson(json);
  PaymentRequestBody({
    this.userId,
    this.name,
    this.nickname,
    this.paymentTypeId,
    this.order,
    this.cardNum,
    this.cardCvv,
    this.cardExpiryMonth,
    this.cardExpiryYear,
  });

  @JsonKey(name: 'userId')
  String? userId;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'nickname')
  String? nickname;

  @JsonKey(name: 'paymentTypeId')
  String? paymentTypeId;

  @JsonKey(name: 'order')
  int? order;

  @JsonKey(name: 'cardNum')
  String? cardNum;

  @JsonKey(name: 'cardCvv')
  String? cardCvv;

  @JsonKey(name: 'cardExpiryMonth')
  int? cardExpiryMonth;

  @JsonKey(name: 'cardExpiryYear')
  int? cardExpiryYear;

  Map<String, dynamic> toJson() => _$PaymentRequestBodyToJson(this);
}

@JsonSerializable()
class PaymentMethodUpdateRequestBody {
  factory PaymentMethodUpdateRequestBody.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodUpdateRequestBodyFromJson(json);
  PaymentMethodUpdateRequestBody({this.nickname});

  @JsonKey(name: 'nickname')
  String? nickname;

  Map<String, dynamic> toJson() => _$PaymentMethodUpdateRequestBodyToJson(this);
}
