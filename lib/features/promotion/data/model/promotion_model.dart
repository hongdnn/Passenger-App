import 'package:json_annotation/json_annotation.dart';

part 'promotion_model.g.dart';

@JsonSerializable()
class PromotionResponseModel {
  factory PromotionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PromotionResponseModelFromJson(json);

  PromotionResponseModel({
    this.errorMessage,
    this.status,
    this.data,
  });

  String? errorMessage;
  int? status;
  PromotionModelData? data;

  Map<String, dynamic> toJson() => _$PromotionResponseModelToJson(this);
}

@JsonSerializable()
class PromotionModelData {
  factory PromotionModelData.fromJson(Map<String, dynamic> json) =>
      _$PromotionModelDataFromJson(json);

  PromotionModelData({
    this.promotionList,
    this.pagination,
  });

  List<PromotionData>? promotionList;
  Pagination? pagination;
  Map<String, dynamic> toJson() => _$PromotionModelDataToJson(this);
}

@JsonSerializable()
class Pagination {
  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Pagination({
    this.currentPage,
    this.pageSize,
    this.hasNextPage,
    this.hasPreviousPage,
  });

  int? currentPage;
  int? pageSize;
  bool? hasNextPage;
  bool? hasPreviousPage;

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}

@JsonSerializable()
class PromotionData {
  factory PromotionData.fromJson(Map<String, dynamic> json) =>
      _$PromotionDataFromJson(json);

  PromotionData({
    this.promotionId,
    this.promotionName,
    this.shortDescription,
    this.promotionLink,
    this.promotionType,
    this.iconUrl,
    this.type,
    this.voucherCode,
    this.promotionCode,
    this.discount,
    this.discountType,
    this.discountFor,
    this.startDate,
    this.endDate,
    this.maximumDiscount,
    this.applicationKey,
  });

  int? promotionId;
  String? promotionName;
  String? shortDescription;
  String? promotionLink;
  String? promotionType;
  String? iconUrl;
  String? type;
  String? voucherCode;
  String? promotionCode;
  double? discount;
  String? discountType;
  String? discountFor;
  String? startDate;
  String? endDate;
  double? maximumDiscount;
  String? applicationKey;

  Map<String, dynamic> toJson() => _$PromotionDataToJson(this);

  bool isPromotionValid() {
    return (promotionId != null ||
        promotionCode != null ||
        voucherCode != null);
  }
}
