// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceDetailModel _$PlaceDetailModelFromJson(Map<String, dynamic> json) =>
    PlaceDetailModel(
      htmlAttributions: json['htmlAttributions'] as List<dynamic>?,
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$PlaceDetailModelToJson(PlaceDetailModel instance) =>
    <String, dynamic>{
      'htmlAttributions': instance.htmlAttributions,
      'result': instance.result,
      'status': instance.status,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      addressComponents: (json['addressComponents'] as List<dynamic>?)
          ?.map((e) => AddressComponent.fromJson(e as Map<String, dynamic>))
          .toList(),
      adrAddress: json['adrAddress'] as String?,
      formattedAddress: json['formatted_address'] as String?,
      geometry: json['geometry'] == null
          ? null
          : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
      icon: json['icon'] as String?,
      iconBackgroundColor: json['iconBackgroundColor'] as String?,
      iconMaskBaseUri: json['iconMaskBaseUri'] as String?,
      name: json['name'] as String?,
      placeId: json['place_id'] as String?,
      plusCode: json['plusCode'] == null
          ? null
          : PlusCode.fromJson(json['plusCode'] as Map<String, dynamic>),
      reference: json['reference'] as String?,
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
      url: json['url'] as String?,
      utcOffset: json['utcOffset'] as int?,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'addressComponents': instance.addressComponents,
      'adrAddress': instance.adrAddress,
      'formatted_address': instance.formattedAddress,
      'geometry': instance.geometry,
      'icon': instance.icon,
      'iconBackgroundColor': instance.iconBackgroundColor,
      'iconMaskBaseUri': instance.iconMaskBaseUri,
      'name': instance.name,
      'place_id': instance.placeId,
      'plusCode': instance.plusCode,
      'reference': instance.reference,
      'types': instance.types,
      'url': instance.url,
      'utcOffset': instance.utcOffset,
    };

AddressComponent _$AddressComponentFromJson(Map<String, dynamic> json) =>
    AddressComponent(
      longName: json['longName'] as String?,
      shortName: json['shortName'] as String?,
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AddressComponentToJson(AddressComponent instance) =>
    <String, dynamic>{
      'longName': instance.longName,
      'shortName': instance.shortName,
      'types': instance.types,
    };

Geometry _$GeometryFromJson(Map<String, dynamic> json) => Geometry(
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      viewport: json['viewport'] == null
          ? null
          : Viewport.fromJson(json['viewport'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GeometryToJson(Geometry instance) => <String, dynamic>{
      'location': instance.location,
      'viewport': instance.viewport,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

Viewport _$ViewportFromJson(Map<String, dynamic> json) => Viewport(
      northeast: json['northeast'] == null
          ? null
          : Location.fromJson(json['northeast'] as Map<String, dynamic>),
      southwest: json['southwest'] == null
          ? null
          : Location.fromJson(json['southwest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ViewportToJson(Viewport instance) => <String, dynamic>{
      'northeast': instance.northeast,
      'southwest': instance.southwest,
    };

PlusCode _$PlusCodeFromJson(Map<String, dynamic> json) => PlusCode(
      compoundCode: json['compoundCode'] as String?,
      globalCode: json['globalCode'] as String?,
    );

Map<String, dynamic> _$PlusCodeToJson(PlusCode instance) => <String, dynamic>{
      'compoundCode': instance.compoundCode,
      'globalCode': instance.globalCode,
    };
