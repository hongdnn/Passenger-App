import 'package:json_annotation/json_annotation.dart';
import 'package:passenger/features/promotion/data/model/promotion_model.dart';

part 'promotion_search.g.dart';

@JsonSerializable()
class PromotionSearchRequestBody {
  factory PromotionSearchRequestBody.fromJson(Map<String, dynamic> json) =>
      _$PromotionSearchRequestBodyFromJson(json);

  PromotionSearchRequestBody({
    this.userId,
    this.voucherCode,
  });

  String? userId;
  String? voucherCode;

  Map<String, dynamic> toJson() => _$PromotionSearchRequestBodyToJson(this);
}

@JsonSerializable()
class PromotionSearchResponse {
  factory PromotionSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$PromotionSearchResponseFromJson(json);

  PromotionSearchResponse({
    this.resultCode,
    this.errorMessage,
    this.data,
  });

  int? resultCode;
  String? errorMessage;
  PromotionData? data;

  Map<String, dynamic> toJson() => _$PromotionSearchResponseToJson(this);
}
