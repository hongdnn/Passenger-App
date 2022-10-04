import 'package:json_annotation/json_annotation.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';

part 'booking_history_model.g.dart';

@JsonSerializable()
class BookingHistoryModel {
  factory BookingHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$BookingHistoryModelFromJson(json);

  BookingHistoryModel({
    this.status,
    this.errorMessage,
    this.data,
  });

  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'errorMessage')
  String? errorMessage;
  @JsonKey(name: 'data')
  List<BookingData>? data;

  Map<String, dynamic> toJson() => _$BookingHistoryModelToJson(this);
}