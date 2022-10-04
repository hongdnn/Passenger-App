import 'package:json_annotation/json_annotation.dart';
part 'booking_history_sort_by_time_model.g.dart';

@JsonSerializable()
class BookingHistorySortByTimeModel {
  factory BookingHistorySortByTimeModel.fromJson(Map<String, dynamic> json) =>
      _$BookingHistorySortByTimeModelFromJson(json);

  BookingHistorySortByTimeModel({
    this.status,
    this.errorMessage,
    this.data,
  });

  @JsonKey(name: 'status')
  int? status;

  @JsonKey(name: 'errorMessage')
  String? errorMessage;

  @JsonKey(name: 'data')
  List<BookingDataSortByTime>? data;

  Map<String, dynamic> toJson() => _$BookingHistorySortByTimeModelToJson(this);
}

@JsonSerializable()
class BookingDataSortByTime {
  factory BookingDataSortByTime.fromJson(Map<String, dynamic> json) =>
      _$BookingDataSortByTimeFromJson(json);
  BookingDataSortByTime({
    this.longitude,
    this.latitude,
    this.address,
    this.googleId,
    this.referenceId,
    this.addressName,
  });

  double? longitude;
  double? latitude;
  String? address;
  String? googleId;
  String? referenceId;
  String? addressName;

  Map<String, dynamic> toJson() => _$BookingDataSortByTimeToJson(this);
}
