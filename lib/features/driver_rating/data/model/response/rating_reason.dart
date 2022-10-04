import 'package:json_annotation/json_annotation.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';

part 'rating_reason.g.dart';

@JsonSerializable()
class RatingOptionsResponse {
  RatingOptionsResponse({
    this.errorMessage,
    this.status,
    this.data,
  });

  factory RatingOptionsResponse.fromJson(Map<String, dynamic> json) =>
      _$RatingOptionsResponseFromJson(json);

  @JsonKey(name: 'status')
  int? status;

  @JsonKey(name: 'errorMessage')
  String? errorMessage;

  @JsonKey(name: 'data')
  RatingOptions? data;

  Map<String, dynamic> toJson() => _$RatingOptionsResponseToJson(this);
}

@JsonSerializable()
class RatingOptions {
  factory RatingOptions.fromJson(Map<String, dynamic> json) =>
      _$RatingOptionsFromJson(json);

  const RatingOptions({
    this.driverInfo,
    this.reviews,
    this.tipAmounts,
  });

  @JsonKey(name: 'driverInfo')
  final DriverInfo? driverInfo;

  @JsonKey(name: 'reviews')
  final List<Review>? reviews;

  @JsonKey(name: 'tipAmounts')
  final List<num>? tipAmounts;

  Map<String, dynamic> toJson() => _$RatingOptionsToJson(this);
}

@JsonSerializable()
class Review {
  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Review({
    this.ratingStar,
    this.reasons,
  });

  @JsonKey(name: 'ratingStar')
  List<num>? ratingStar;

  @JsonKey(name: 'reasons')
  List<String>? reasons;

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
