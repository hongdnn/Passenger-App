import 'package:json_annotation/json_annotation.dart';

part 'search_driver_for_booking_model.g.dart';

// @JsonSerializable()
// class SearchDriverForBookingModel {
//   factory SearchDriverForBookingModel.fromJson(Map<String, dynamic> json) =>
//       _$SearchDriverForBookingModelFromJson(json);

//   SearchDriverForBookingModel({
//     this.errorMessage,
//     this.status,
//     this.data,
//   });
//   @JsonKey(name: 'errorMessage')
//   String? errorMessage;
//   @JsonKey(name: 'status')
//   int? status;
//   @JsonKey(name: 'data')
//   Data? data;
//   Map<String, dynamic> toJson() => _$SearchDriverForBookingModelToJson(this);
// }

// @JsonSerializable()
// class Data {
//   factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
//   Data({
//     this.id,
//     this.driverAppBookingId,
//   });

//   @JsonKey(name: 'id')
//   String? id;
//   @JsonKey(name: 'driverAppBookingId')
//   String? driverAppBookingId;
//   Map<String, dynamic> toJson() => _$DataToJson(this);
// }

@JsonSerializable()
class SearchDriverForBookingModel {
  factory SearchDriverForBookingModel.fromJson(Map<String, dynamic> json) =>
      _$SearchDriverForBookingModelFromJson(json);

  SearchDriverForBookingModel({this.status, this.errorMessage, this.data});
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'errorMessage')
  String? errorMessage;
  @JsonKey(name: 'data')
  DataSearchDriverForBooking? data;
  Map<String, dynamic> toJson() => _$SearchDriverForBookingModelToJson(this);
}

@JsonSerializable()
class DataSearchDriverForBooking {
  factory DataSearchDriverForBooking.fromJson(Map<String, dynamic> json) =>
      _$DataSearchDriverForBookingFromJson(json);
  DataSearchDriverForBooking({
    this.id,
    this.driverAppBookingId,
  });

  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'driverAppBookingId')
  String? driverAppBookingId;
  Map<String, dynamic> toJson() => _$DataSearchDriverForBookingToJson(this);
}

@JsonSerializable()
class SearchDriverForBookingResponse {
  factory SearchDriverForBookingResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchDriverForBookingResponseFromJson(json);

  SearchDriverForBookingResponse({
    this.bookingId,
  });

  @JsonKey(name: 'bookingId')
  String? bookingId;

  Map<String, dynamic> toJson() => _$SearchDriverForBookingResponseToJson(this);
}
