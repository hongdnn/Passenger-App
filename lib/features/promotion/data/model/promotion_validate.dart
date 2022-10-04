import 'package:json_annotation/json_annotation.dart';

part 'promotion_validate.g.dart';

@JsonSerializable()
class PromotionValidateRequest {
  factory PromotionValidateRequest.fromJson(Map<String, dynamic> json) =>
      _$PromotionValidateRequestFromJson(json);

  PromotionValidateRequest({
    this.userId,
    this.promotionId,
    this.promotionCode,
    this.voucherCode,
    this.orderAmount,
    this.discountAmount,
  });

  String? userId;
  int? promotionId;
  String? promotionCode;
  String? voucherCode;
  double? orderAmount;
  double? discountAmount;

  Map<String, dynamic> toJson() => _$PromotionValidateRequestToJson(this);
}

@JsonSerializable()
class PromotionValidateResponseModel {
  factory PromotionValidateResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PromotionValidateResponseModelFromJson(json);

  PromotionValidateResponseModel({
    this.errorMessage,
    this.status,
    this.data,
  });

  String? errorMessage;
  int? status;
  PromotionValidateModel? data;

  Map<String, dynamic> toJson() => _$PromotionValidateResponseModelToJson(this);
}

@JsonSerializable()
class PromotionValidateModel {
  factory PromotionValidateModel.fromJson(Map<String, dynamic> json) =>
      _$PromotionValidateModelFromJson(json);

  PromotionValidateModel({
    this.isValid,
    this.discountAmount,
  });

  bool? isValid;
  double? discountAmount;

  Map<String, dynamic> toJson() => _$PromotionValidateModelToJson(this);
}
