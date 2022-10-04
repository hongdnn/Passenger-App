import 'package:json_annotation/json_annotation.dart';
import 'package:passenger/core/base_model/base_data_model.dart';
part 'rating_result.g.dart';

@JsonSerializable()
class RatingResultResponse extends BaseDataModel<RatingResult> {
  RatingResultResponse({
    super.errorMessage,
    super.status,
    super.data,
  });

  factory RatingResultResponse.fromJson(Map<String, dynamic> json) =>
      _$RatingResultResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RatingResultResponseToJson(this);
}

@JsonSerializable()
class RatingResult {
  factory RatingResult.fromJson(Map<String, dynamic> json) =>
      _$RatingResultFromJson(json);

  RatingResult({
    this.status,
    this.submitRating,
  });

  @JsonKey(name: 'submitRating')
  SubmitRating? submitRating;

  @JsonKey(name: 'status')
  String? status;
}

@JsonSerializable()
class SubmitRating {
  factory SubmitRating.fromJson(Map<String, dynamic> json) =>
      _$SubmitRatingFromJson(json);

  SubmitRating({
    this.additionalComments,
    this.bookingId,
    this.rating,
    this.ratingReasons,
    this.tipAmount,
  });

  @JsonKey(name: 'bookingId')
  String? bookingId;

  @JsonKey(name: 'rating')
  num? rating;

  @JsonKey(name: 'ratingReasons')
  List<String>? ratingReasons;

  @JsonKey(name: 'tipAmount')
  num? tipAmount;

  @JsonKey(name: 'additionalComments')
  String? additionalComments;
}
