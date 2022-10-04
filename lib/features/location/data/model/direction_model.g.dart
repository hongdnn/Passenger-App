// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectionModel _$DirectionModelFromJson(Map<String, dynamic> json) =>
    DirectionModel(
      status: json['status'] as String?,
      geocodedWaypoints: (json['geocoded_waypoints'] as List<dynamic>?)
          ?.map((e) => GeocodedWaypoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      routes: (json['routes'] as List<dynamic>?)
          ?.map((e) => Route.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DirectionModelToJson(DirectionModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'geocoded_waypoints': instance.geocodedWaypoints,
      'routes': instance.routes,
    };

GeocodedWaypoint _$GeocodedWaypointFromJson(Map<String, dynamic> json) =>
    GeocodedWaypoint(
      geocoderStatus: json['geocoder_status'] as String?,
      placeId: json['place_id'] as String?,
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$GeocodedWaypointToJson(GeocodedWaypoint instance) =>
    <String, dynamic>{
      'geocoder_status': instance.geocoderStatus,
      'place_id': instance.placeId,
      'types': instance.types,
    };

Route _$RouteFromJson(Map<String, dynamic> json) => Route(
      bounds: json['bounds'] == null
          ? null
          : Bounds.fromJson(json['bounds'] as Map<String, dynamic>),
      copyrights: json['copyrights'] as String?,
      legs: (json['legs'] as List<dynamic>?)
          ?.map((e) => Leg.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..overviewPolyline = json['overview_polyline'] == null
        ? null
        : OverviewPolyline.fromJson(
            json['overview_polyline'] as Map<String, dynamic>);

Map<String, dynamic> _$RouteToJson(Route instance) => <String, dynamic>{
      'bounds': instance.bounds,
      'copyrights': instance.copyrights,
      'legs': instance.legs,
      'overview_polyline': instance.overviewPolyline,
    };

OverviewPolyline _$OverviewPolylineFromJson(Map<String, dynamic> json) =>
    OverviewPolyline(
      points: json['points'] as String?,
    );

Map<String, dynamic> _$OverviewPolylineToJson(OverviewPolyline instance) =>
    <String, dynamic>{
      'points': instance.points,
    };

Bounds _$BoundsFromJson(Map<String, dynamic> json) => Bounds(
      northeast: json['northeast'] == null
          ? null
          : BoundSide.fromJson(json['northeast'] as Map<String, dynamic>),
      southwest: json['southwest'] == null
          ? null
          : BoundSide.fromJson(json['southwest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BoundsToJson(Bounds instance) => <String, dynamic>{
      'northeast': instance.northeast,
      'southwest': instance.southwest,
    };

BoundSide _$BoundSideFromJson(Map<String, dynamic> json) => BoundSide(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$BoundSideToJson(BoundSide instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

Leg _$LegFromJson(Map<String, dynamic> json) => Leg(
      distance: json['distance'] == null
          ? null
          : Distance.fromJson(json['distance'] as Map<String, dynamic>),
      duration: json['duration'] == null
          ? null
          : DurationModel.fromJson(json['duration'] as Map<String, dynamic>),
      endAddress: json['end_address'] as String?,
      endLocation: json['end_location'] == null
          ? null
          : DirectionLocation.fromJson(
              json['end_location'] as Map<String, dynamic>),
      startAddress: json['start_address'] as String?,
      startLocation: json['start_location'] == null
          ? null
          : DirectionLocation.fromJson(
              json['start_location'] as Map<String, dynamic>),
      steps: (json['steps'] as List<dynamic>?)
          ?.map((e) => Step.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LegToJson(Leg instance) => <String, dynamic>{
      'distance': instance.distance,
      'duration': instance.duration,
      'end_address': instance.endAddress,
      'end_location': instance.endLocation,
      'start_address': instance.startAddress,
      'start_location': instance.startLocation,
      'steps': instance.steps,
    };

Distance _$DistanceFromJson(Map<String, dynamic> json) => Distance(
      text: json['text'] as String?,
      value: (json['value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DistanceToJson(Distance instance) => <String, dynamic>{
      'text': instance.text,
      'value': instance.value,
    };

DurationModel _$DurationModelFromJson(Map<String, dynamic> json) =>
    DurationModel(
      text: json['text'] as String?,
      value: (json['value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DurationModelToJson(DurationModel instance) =>
    <String, dynamic>{
      'text': instance.text,
      'value': instance.value,
    };

DirectionLocation _$DirectionLocationFromJson(Map<String, dynamic> json) =>
    DirectionLocation(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DirectionLocationToJson(DirectionLocation instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

Step _$StepFromJson(Map<String, dynamic> json) => Step(
      distance: json['distance'] == null
          ? null
          : Distance.fromJson(json['distance'] as Map<String, dynamic>),
      duration: json['duration'] == null
          ? null
          : DurationModel.fromJson(json['duration'] as Map<String, dynamic>),
      endLocation: json['end_location'] == null
          ? null
          : DirectionLocation.fromJson(
              json['end_location'] as Map<String, dynamic>),
      startLocation: json['start_location'] == null
          ? null
          : DirectionLocation.fromJson(
              json['start_location'] as Map<String, dynamic>),
      htmlInstructions: json['html_instructions'] as String?,
      travelMode: json['travel_mode'] as String?,
      polyline: json['polyline'] == null
          ? null
          : PolylineModel.fromJson(json['polyline'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StepToJson(Step instance) => <String, dynamic>{
      'distance': instance.distance,
      'duration': instance.duration,
      'end_location': instance.endLocation,
      'start_location': instance.startLocation,
      'html_instructions': instance.htmlInstructions,
      'travel_mode': instance.travelMode,
      'polyline': instance.polyline,
    };

PolylineModel _$PolylineModelFromJson(Map<String, dynamic> json) =>
    PolylineModel(
      points: json['points'] as String?,
    );

Map<String, dynamic> _$PolylineModelToJson(PolylineModel instance) =>
    <String, dynamic>{
      'points': instance.points,
    };
