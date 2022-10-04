import 'package:json_annotation/json_annotation.dart';

part 'rate_driver_request.g.dart';

@JsonSerializable()
class RateDriverRequest {
  factory RateDriverRequest.fromJson(Map<String, dynamic> json) =>
      _$RateDriverRequestFromJson(json);
  RateDriverRequest({
    required this.bookingId,
    this.rating,
    this.ratingReasons,
    this.tipAmount,
    this.additionalComments,
  });

  @JsonKey(name: 'bookingId')
  final String? bookingId;

  @JsonKey(name: 'rating')
  final num? rating;

  @JsonKey(name: 'ratingReasons')
  final List<String>? ratingReasons;

  @JsonKey(name: 'tipAmount')
  final num? tipAmount;

  @JsonKey(name: 'additionalComments')
  final String? additionalComments;

  Map<String, dynamic> toJson() => _$RateDriverRequestToJson(this);
}
