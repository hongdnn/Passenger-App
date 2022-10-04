import 'package:json_annotation/json_annotation.dart';

part 'direction_model.g.dart';

@JsonSerializable()
class DirectionModel {
  factory DirectionModel.fromJson(Map<String, dynamic> json) =>
      _$DirectionModelFromJson(json);
  DirectionModel({this.status, this.geocodedWaypoints, this.routes});

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'geocoded_waypoints')
  List<GeocodedWaypoint>? geocodedWaypoints;

  @JsonKey(name: 'routes')
  List<Route>? routes;

  Map<String, dynamic> toJson() => _$DirectionModelToJson(this);
}

@JsonSerializable()
class GeocodedWaypoint {
  factory GeocodedWaypoint.fromJson(Map<String, dynamic> json) =>
      _$GeocodedWaypointFromJson(json);
  GeocodedWaypoint({
    this.geocoderStatus,
    this.placeId,
    this.types,
  });

  @JsonKey(name: 'geocoder_status')
  String? geocoderStatus;

  @JsonKey(name: 'place_id')
  String? placeId;

  @JsonKey(name: 'types')
  List<String>? types;

  Map<String, dynamic> toJson() => _$GeocodedWaypointToJson(this);
}

@JsonSerializable()
class Route {
  Route({this.bounds, this.copyrights, this.legs});
  factory Route.fromJson(Map<String, dynamic> json) => _$RouteFromJson(json);

  @JsonKey(name: 'bounds')
  Bounds? bounds;

  @JsonKey(name: 'copyrights')
  String? copyrights;

  @JsonKey(name: 'legs')
  List<Leg>? legs;

  @JsonKey(name: 'overview_polyline')
  OverviewPolyline? overviewPolyline;

  Map<String, dynamic> toJson() => _$RouteToJson(this);
}

@JsonSerializable()
class OverviewPolyline {
  factory OverviewPolyline.fromJson(Map<String, dynamic> json) =>
      _$OverviewPolylineFromJson(json);
  OverviewPolyline({this.points});
  String? points;
  Map<String, dynamic> toJson() => _$OverviewPolylineToJson(this);
}

@JsonSerializable()
class Bounds {
  Bounds({this.northeast, this.southwest});

  factory Bounds.fromJson(Map<String, dynamic> json) => _$BoundsFromJson(json);

  @JsonKey(name: 'northeast')
  BoundSide? northeast;

  @JsonKey(name: 'southwest')
  BoundSide? southwest;

  Map<String, dynamic> toJson() => _$BoundsToJson(this);
}

@JsonSerializable()
class BoundSide {
  BoundSide({this.lat, this.lng});

  factory BoundSide.fromJson(Map<String, dynamic> json) =>
      _$BoundSideFromJson(json);

  @JsonKey(name: 'lat')
  double? lat;

  @JsonKey(name: 'lng')
  double? lng;

  Map<String, dynamic> toJson() => _$BoundSideToJson(this);
}

@JsonSerializable()
class Leg {
  Leg({
    this.distance,
    this.duration,
    this.endAddress,
    this.endLocation,
    this.startAddress,
    this.startLocation,
    this.steps,
  });

  factory Leg.fromJson(Map<String, dynamic> json) => _$LegFromJson(json);
  @JsonKey(name: 'distance')
  Distance? distance;

  @JsonKey(name: 'duration')
  DurationModel? duration;

  @JsonKey(name: 'end_address')
  String? endAddress;

  @JsonKey(name: 'end_location')
  DirectionLocation? endLocation;

  @JsonKey(name: 'start_address')
  String? startAddress;

  @JsonKey(name: 'start_location')
  DirectionLocation? startLocation;

  @JsonKey(name: 'steps')
  List<Step>? steps;

  Map<String, dynamic> toJson() => _$LegToJson(this);
}

@JsonSerializable()
class Distance {
  Distance({this.text, this.value});

  factory Distance.fromJson(Map<String, dynamic> json) =>
      _$DistanceFromJson(json);
  @JsonKey(name: 'text')
  String? text;

  @JsonKey(name: 'value')
  double? value;

  Map<String, dynamic> toJson() => _$DistanceToJson(this);
}

@JsonSerializable()
class DurationModel {
  DurationModel({this.text, this.value});

  factory DurationModel.fromJson(Map<String, dynamic> json) =>
      _$DurationModelFromJson(json);
  @JsonKey(name: 'text')
  String? text;

  @JsonKey(name: 'value')
  double? value;

  Map<String, dynamic> toJson() => _$DurationModelToJson(this);
}

@JsonSerializable()
class DirectionLocation {
  factory DirectionLocation.fromJson(Map<String, dynamic> json) =>
      _$DirectionLocationFromJson(json);
  DirectionLocation({
    this.lat,
    this.lng,
  });

  double? lat;
  double? lng;

  Map<String, dynamic> toJson() => _$DirectionLocationToJson(this);
}

@JsonSerializable()
class Step {
  Step({
    this.distance,
    this.duration,
    this.endLocation,
    this.startLocation,
    this.htmlInstructions,
    this.travelMode,
    this.polyline,
  });

  factory Step.fromJson(Map<String, dynamic> json) => _$StepFromJson(json);
  @JsonKey(name: 'distance')
  Distance? distance;

  @JsonKey(name: 'duration')
  DurationModel? duration;

  @JsonKey(name: 'end_location')
  DirectionLocation? endLocation;

  @JsonKey(name: 'start_location')
  DirectionLocation? startLocation;

  @JsonKey(name: 'html_instructions')
  String? htmlInstructions;

  @JsonKey(name: 'travel_mode')
  String? travelMode;

  @JsonKey(name: 'polyline')
  PolylineModel? polyline;

  Map<String, dynamic> toJson() => _$StepToJson(this);
}

@JsonSerializable()
class PolylineModel {
  factory PolylineModel.fromJson(Map<String, dynamic> json) =>
      _$PolylineModelFromJson(json);
  PolylineModel({this.points});
  @JsonKey(name: 'points')
  String? points;
  Map<String, dynamic> toJson() => _$PolylineModelToJson(this);
}
