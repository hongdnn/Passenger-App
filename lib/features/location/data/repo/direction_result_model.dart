import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Each option includes
// all directions between start and end, totalTime, totalDistance
class TotalDirectionResultModel {
  TotalDirectionResultModel({
    this.routeOptions,
    this.totalDistance,
    this.totalDuration,
  });

  List<DirectionResultModel>? routeOptions;
  double? totalDuration;
  double? totalDistance;
}

// Each direction includes: distance, duration and polylines between 2 points
class DirectionResultModel {
  factory DirectionResultModel.emptyResult() {
    return DirectionResultModel(
      distance: 0,
      duration: 0,
      polyline: null,
      pathToLocation: 
      null,
    );
  }
  DirectionResultModel({
    this.distance,
    this.duration,
    this.polyline,
   required this.pathToLocation,
  });
  Polyline? polyline;
  double? duration;
  double? distance;
  String? pathToLocation;
}

extension PolylineExt on Polyline {
  Polyline copyWithNewId({
    Color? colorParam,
    bool? consumeTapEventsParam,
    Cap? endCapParam,
    bool? geodesicParam,
    JointType? jointTypeParam,
    List<PatternItem>? patternsParam,
    List<LatLng>? pointsParam,
    Cap? startCapParam,
    bool? visibleParam,
    int? widthParam,
    int? zIndexParam,
    VoidCallback? onTapParam,
  }) {
    return Polyline(
      consumeTapEvents: consumeTapEventsParam ?? consumeTapEvents,
      color: colorParam ?? color,
      endCap: endCapParam ?? endCap,
      geodesic: geodesicParam ?? geodesic,
      jointType: jointTypeParam ?? jointType,
      patterns: patternsParam ?? patterns,
      points: pointsParam ?? points,
      startCap: startCapParam ?? startCap,
      visible: visibleParam ?? visible,
      width: widthParam ?? width,
      zIndex: zIndexParam ?? zIndex,
      onTap: onTapParam ?? onTap,
      polylineId: PolylineId(DateTime.now().toString()),
    );
  }
}
