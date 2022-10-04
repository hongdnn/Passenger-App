// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upsert_draft_booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpsertDraftBookingModel _$UpsertDraftBookingModelFromJson(
        Map<String, dynamic> json) =>
    UpsertDraftBookingModel(
      status: json['status'] as int?,
      errorMessage: json['errorMessage'] as String?,
      data: json['data'] == null
          ? null
          : UpsertDraftData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpsertDraftBookingModelToJson(
        UpsertDraftBookingModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'data': instance.data,
    };

UpsertDraftData _$UpsertDraftDataFromJson(Map<String, dynamic> json) =>
    UpsertDraftData(
      id: json['id'] as String?,
      deviceId: json['deviceId'] as String?,
      carType: json['carType'] as int?,
      isDrafting: json['isDrafting'] as bool?,
      startTime: json['startTime'],
      copyTripId: json['copyTripId'],
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      locations: (json['locations'] as List<dynamic>?)
          ?.map((e) => TripLocation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UpsertDraftDataToJson(UpsertDraftData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deviceId': instance.deviceId,
      'carType': instance.carType,
      'isDrafting': instance.isDrafting,
      'startTime': instance.startTime,
      'copyTripId': instance.copyTripId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'locations': instance.locations,
    };

UpsertRequestBody _$UpsertRequestBodyFromJson(Map<String, dynamic> json) =>
    UpsertRequestBody(
      deviceId: json['deviceId'] as String?,
      carType: json['carType'] as int?,
      locations: (json['locations'] as List<dynamic>?)
          ?.map((e) => LocationRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      startTime: json['startTime'],
      isSilent: json['isSilent'] as bool?,
      noteForDriver: json['noteForDriver'] as String?,
      isTripLater: json['isTripLater'] as bool?,
      distance: (json['distance'] as num?)?.toDouble(),
      totalTime: (json['totalTime'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UpsertRequestBodyToJson(UpsertRequestBody instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'carType': instance.carType,
      'locations': instance.locations,
      'startTime': instance.startTime,
      'isSilent': instance.isSilent,
      'noteForDriver': instance.noteForDriver,
      'isTripLater': instance.isTripLater,
      'distance': instance.distance,
      'totalTime': instance.totalTime,
      'price': instance.price,
    };

LocationRequest _$LocationRequestFromJson(Map<String, dynamic> json) =>
    LocationRequest(
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      address: json['address'] as String?,
      note: json['note'] as String?,
      googleId: json['googleId'] as String?,
      referenceId: json['referenceId'] as String?,
      addressName: json['addressName'] as String?,
      pathToLocation: json['pathToLocation'] as String?,
    );

Map<String, dynamic> _$LocationRequestToJson(LocationRequest instance) =>
    <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'address': instance.address,
      'note': instance.note,
      'googleId': instance.googleId,
      'referenceId': instance.referenceId,
      'addressName': instance.addressName,
      'pathToLocation': instance.pathToLocation,
    };
