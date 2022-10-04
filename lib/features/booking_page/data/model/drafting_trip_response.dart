import 'package:json_annotation/json_annotation.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';

part 'drafting_trip_response.g.dart';

@JsonSerializable()
class DraftingTripResponse {
  factory DraftingTripResponse.fromJson(Map<String, dynamic> json) =>
      _$DraftingTripResponseFromJson(json);
  DraftingTripResponse({
    this.errorMessage,
    this.status,
    this.data,
  });

  @JsonKey(name: 'errorMessage')
  String? errorMessage;

  @JsonKey(name: 'status')
  int? status;

  @JsonKey(name: 'data')
  Trip? data;

  Map<String, dynamic> toJson() => _$DraftingTripResponseToJson(this);
}
