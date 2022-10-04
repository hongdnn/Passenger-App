import 'package:json_annotation/json_annotation.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
import 'package:passenger/features/location/data/model/location_address_model.dart';
import 'package:passenger/features/location/data/model/place_detail_model.dart';
part 'upsert_draft_booking_model.g.dart';

@JsonSerializable()
class UpsertDraftBookingModel {
  factory UpsertDraftBookingModel.fromJson(Map<String, dynamic> json) =>
      _$UpsertDraftBookingModelFromJson(json);
  UpsertDraftBookingModel({
    this.status,
    this.errorMessage,
    this.data,
  });

  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'errorMessage')
  String? errorMessage;
  @JsonKey(name: 'data')
  UpsertDraftData? data;

  Map<String, dynamic> toJson() => _$UpsertDraftBookingModelToJson(this);
}

@JsonSerializable()
class UpsertDraftData {
  factory UpsertDraftData.fromJson(Map<String, dynamic> json) =>
      _$UpsertDraftDataFromJson(json);
  UpsertDraftData({
    this.id,
    this.deviceId,
    this.carType,
    this.isDrafting,
    this.startTime,
    this.copyTripId,
    this.createdAt,
    this.updatedAt,
    this.locations,
  });

  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'deviceId')
  String? deviceId;

  @JsonKey(name: 'carType')
  int? carType;

  @JsonKey(name: 'isDrafting')
  bool? isDrafting;

  @JsonKey(name: 'startTime')
  dynamic startTime;

  @JsonKey(name: 'copyTripId')
  dynamic copyTripId;

  @JsonKey(name: 'createdAt')
  String? createdAt;

  @JsonKey(name: 'updatedAt')
  String? updatedAt;

  @JsonKey(name: 'locations')
  List<TripLocation>? locations;

  Map<String, dynamic> toJson() => _$UpsertDraftDataToJson(this);
}

@JsonSerializable()
class UpsertRequestBody {
  factory UpsertRequestBody.fromJson(Map<String, dynamic> json) =>
      _$UpsertRequestBodyFromJson(json);
  UpsertRequestBody({
    this.deviceId,
    this.carType,
    this.locations,
    this.startTime,
    this.isSilent,
    this.noteForDriver,
    this.isTripLater,
    this.distance,
    this.totalTime,
    this.price,
  });

  @JsonKey(name: 'deviceId')
  String? deviceId;

  @JsonKey(name: 'carType')
  int? carType;

  @JsonKey(name: 'locations')
  List<LocationRequest>? locations;

  @JsonKey(name: 'startTime')
  dynamic startTime;

  @JsonKey(name: 'isSilent')
  bool? isSilent;

  @JsonKey(name: 'noteForDriver')
  String? noteForDriver;

  @JsonKey(name: 'isTripLater')
  bool? isTripLater;

  @JsonKey(name: 'distance')
  double? distance;

  @JsonKey(name: 'totalTime')
  double? totalTime;

  @JsonKey(name: 'price')
  double? price;

  Map<String, dynamic> toJson() => _$UpsertRequestBodyToJson(this);
}

@JsonSerializable()
class LocationRequest {
  factory LocationRequest.fromTripLocation(TripLocation tripLocation) {
    return LocationRequest(
      latitude: tripLocation.latitude,
      longitude: tripLocation.longitude,
      address: tripLocation.address,
      note: tripLocation.note.toString(),
      googleId: tripLocation.googleId,
      referenceId: tripLocation.referenceId,
      addressName: tripLocation.addressName,
      pathToLocation: tripLocation.pathToLocation,
    );
  }
  factory LocationRequest.fromJson(Map<String, dynamic> json) =>
      _$LocationRequestFromJson(json);
  LocationRequest({
    this.longitude,
    this.latitude,
    this.address,
    this.note,
    this.googleId,
    this.referenceId,
    this.addressName,
    this.pathToLocation,
  });
  factory LocationRequest.fromLocationAddressModel(
    LocationAddressModel locationAddressModel,
  ) {
    return LocationRequest(
      latitude: locationAddressModel.latitude,
      longitude: locationAddressModel.longitude,
      address: locationAddressModel.formatAddress,
      addressName: locationAddressModel.nameAddress,
      googleId: locationAddressModel.placeId,
      referenceId: locationAddressModel.reference,
      pathToLocation: '',
    );
  }

  factory LocationRequest.fromPlaceDetail(
    PlaceDetailModel placeDetailModel,
  ) {
    return LocationRequest.fromLocationAddressModel(
      LocationAddressModel.from(placeDetailModel),
    );
  }

  copyWith({
    required String? pathToLocationParams,
  }) {
    pathToLocation = pathToLocationParams;
  }

  @JsonKey(name: 'longitude')
  double? longitude;

  @JsonKey(name: 'latitude')
  double? latitude;

  @JsonKey(name: 'address')
  String? address;

  @JsonKey(name: 'note')
  String? note;

  @JsonKey(name: 'googleId')
  String? googleId;

  @JsonKey(name: 'referenceId')
  String? referenceId;

  @JsonKey(name: 'addressName')
  String? addressName;

  @JsonKey(name: 'pathToLocation')
  String? pathToLocation;

  Map<String, dynamic> toJson() => _$LocationRequestToJson(this);
}
