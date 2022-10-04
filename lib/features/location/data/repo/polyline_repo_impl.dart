part of 'polyline_repo.dart';

/// Must be a Singleton to work properly
class PolylineRepoImpl extends PolylineRepo {
  PolylineRepoImpl(this.ggClientApi);

  final GgClientApi ggClientApi;

  List<DirectionResultModel>? _polylines;
  double? _duration;
  double? _distance;

  @override
  void resetPolylines() {
    _polylines = null;
  }

  // To get direction of more than 3 points
  @override
  Future<DataState<List<TotalDirectionResultModel>>>
      getDirectionFromOriginToDestination({
    required List<DirectionParam> directionParams,
  }) async {
    double totalDistance = 0;
    double totalTime = 0;

    int currentLineIndex = 0;

    List<DirectionResultModel> routesResult = <DirectionResultModel>[];

    try {
      await Future.forEach(
        directionParams,
        (DirectionParam element) async {
          String origin = '${element.start.lat},${element.start.lng}';
          String destination = '${element.end.lat},${element.end.lng}';

          String transportationRoute =
              getTravelTransportation(element.travelMode);

          DirectionModel result =
              await ggClientApi.getDirectionFromOriginToDestination(
            origin: origin,
            destination: destination,
            travelmode: transportationRoute,
            optimizeWaypoints: element.optimizeWaypoints,
            avoidFerries: element.avoidFerries,
            avoidHighways: element.avoidHighways,
            avoidTolls: element.avoidTolls,
          );

          if (result.routes!.isEmpty) {
            throw Exception('Route is empty');
          }
          List<LatLng> listPoint = decodeEncodedPolyline(
            result.routes?[0].overviewPolyline?.points ?? '',
          );

          Polyline polyline = Polyline(
            polylineId: PolylineId('$currentLineIndex'),
            visible: true,
            points: listPoint,
            startCap: Cap.roundCap,
            endCap: Cap.buttCap,
          );

          double distance = result.routes?[0].legs?[0].distance?.value ?? 0;
          double duration = result.routes?[0].legs?[0].duration?.value ?? 0;

          totalTime += duration;
          totalDistance += distance;

          currentLineIndex++;

          routesResult.add(
            DirectionResultModel(
              duration: duration,
              distance: distance,
              polyline: polyline,
              pathToLocation: result.routes?[0].overviewPolyline?.points ?? '',
            ),
          );
        },
      );

      return DataSuccess<List<TotalDirectionResultModel>>(
        <TotalDirectionResultModel>[
          TotalDirectionResultModel(
            routeOptions: routesResult,
            totalDistance: totalDistance,
            totalDuration: totalTime,
          )
        ],
      );
    } on Exception catch (e) {
      return DataFailed<List<TotalDirectionResultModel>>(e);
    }
  }

  @override
  Future<DataState<List<TotalDirectionResultModel>>>
      getAlternativesDirectionFromOriginToDestination({
    required List<DirectionParam> directionParams,
  }) async {
    List<TotalDirectionResultModel> options = <TotalDirectionResultModel>[];

    DirectionParam param = directionParams.first;
    String origin = '${param.start.lat},${param.start.lng}';
    String destination = '${param.end.lat},${param.end.lng}';
    String transportationRoute = getTravelTransportation(param.travelMode);

    try {
      DirectionModel result =
          await ggClientApi.getDirectionFromOriginToDestination(
        origin: origin,
        destination: destination,
        travelmode: transportationRoute,
        optimizeWaypoints: param.optimizeWaypoints,
        avoidFerries: param.avoidFerries,
        avoidHighways: param.avoidHighways,
        avoidTolls: param.avoidTolls,
        alternatives: true,
      );

      List<Route>? routes = result.routes;

      if (routes == null || routes.isEmpty) {
        throw Exception('Route must not be null');
      }

      for (int index = 0; index < routes.length; index++) {
        double distance = 0;
        double duration = 0;
        double totalDistance = 0;
        double totalDuration = 0;
        List<DirectionResultModel> listRouteOptions = <DirectionResultModel>[];

        List<LatLng> listPoint = decodeEncodedPolyline(
          result.routes?[index].overviewPolyline?.points ?? '',
        );
        Polyline polyline = Polyline(
          polylineId: PolylineId('$index'),
          visible: true,
          points: listPoint,
          width: 6.w.toInt(),
          color: ColorsConstant.cFFA33AA3,
          startCap: Cap.roundCap,
          endCap: Cap.buttCap,
          consumeTapEvents: true,
        );

        distance = result.routes?[index].legs?[0].distance?.value ?? 0;
        duration = result.routes?[index].legs?[0].duration?.value ?? 0;

        totalDistance += distance;
        totalDuration += duration;

        listRouteOptions.add(
          DirectionResultModel(
            polyline: polyline,
            distance: distance,
            duration: duration,
            pathToLocation:
                result.routes?[index].overviewPolyline?.points ?? '',
          ),
        );

        options.add(
          TotalDirectionResultModel(
            routeOptions: listRouteOptions,
            totalDistance: totalDistance,
            totalDuration: totalDuration,
          ),
        );
      }
      return DataSuccess<List<TotalDirectionResultModel>>(
        options,
      );
    } on Exception catch (e) {
      return DataFailed<List<TotalDirectionResultModel>>(e);
    }
  }

  @override
  void setPolylines(
    List<DirectionResultModel>? newPolylnes,
    double? duration,
    double? distance,
  ) {
    _polylines = newPolylnes;
    _distance = distance;
    _duration = duration;
  }

  @override
  double? getDuration() {
    return _duration;
  }

  @override
  double? getDistance() {
    return _distance;
  }

  @override
  List<DirectionResultModel>? getLatestPolylineList() {
    return _polylines;
  }
}
