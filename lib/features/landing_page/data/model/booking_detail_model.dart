import 'package:json_annotation/json_annotation.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
part 'booking_detail_model.g.dart';

@JsonSerializable()
class BookingDetailModel {
  factory BookingDetailModel.fromJson(Map<String, dynamic> json) =>
      _$BookingDetailModelFromJson(json);
  BookingDetailModel({
    this.errorMessage,
    this.status,
    this.data,
  });

  @JsonKey(name: 'errorMessage')
  String? errorMessage;

  @JsonKey(name: 'status')
  int? status;

  @JsonKey(name: 'data')
  BookingData? data;

  Map<String, dynamic> toJson() => _$BookingDetailModelToJson(this);
}
