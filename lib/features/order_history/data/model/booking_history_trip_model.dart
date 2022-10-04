import 'package:json_annotation/json_annotation.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';

part 'booking_history_trip_model.g.dart';

@JsonSerializable()
class BookingHistoryTripModel {
  factory BookingHistoryTripModel.fromJson(Map<String, dynamic> json) =>
      _$BookingHistoryTripModelFromJson(json);

  BookingHistoryTripModel({
    this.status,
    this.errorMessage,
    this.data,
  });

  @JsonKey(name: 'status')
  int? status;

  @JsonKey(name: 'errorMessage')
  String? errorMessage;

  @JsonKey(name: 'data')
  DataBooking? data;

  Map<String, dynamic> toJson() => _$BookingHistoryTripModelToJson(this);
}

@JsonSerializable()
class DataBooking {
  factory DataBooking.fromJson(Map<String, dynamic> json) =>
      _$DataBookingFromJson(json);

  DataBooking({
    this.currentPage,
    this.pageSize,
    this.totalCount,
    this.totalPage,
    this.bookings,
  });

  int? currentPage;
  int? pageSize;
  int? totalCount;
  int? totalPage;
  List<BookingData>? bookings;

  Map<String, dynamic> toJson() => _$DataBookingToJson(this);
}