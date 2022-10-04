import 'dart:core';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/data/model/upsert_draft_booking_model.dart';
import 'package:passenger/features/location/data/repo/direction_result_model.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/distance_util.dart';
import 'package:passenger/util/map_marker_generator.dart/marker_generator.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';
import 'package:passenger/util/time_util.dart';

class MapRouteBookingArgs {
  MapRouteBookingArgs({
    required this.locations,
    this.listRouteOptions,
    this.onChangeSelectedRoute,
  });
  List<LocationRequest> locations;
  List<TotalDirectionResultModel>? listRouteOptions;
  Function(int index)? onChangeSelectedRoute;
}

class MapRouteBooking extends StatefulWidget {
  const MapRouteBooking({
    Key? key,
    required this.args,
  }) : super(key: key);

  final MapRouteBookingArgs args;

  @override
  State<MapRouteBooking> createState() => MapRouteBookingState();
}

class MapRouteBookingState extends State<MapRouteBooking> {
  late GoogleMapController googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  late List<LocationRequest> locationList;
  late double distance;
  late int duration;
  late Set<Polyline> polylines;
  late List<TotalDirectionResultModel> listRouteOptions;

  @override
  void initState() {
    super.initState();
    initArgs();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      renderMarker();
    });
  }

  void initArgs() {
    locationList = List<LocationRequest>.from(widget.args.locations);
    listRouteOptions = List<TotalDirectionResultModel>.from(
      widget.args.listRouteOptions ?? <TotalDirectionResultModel>[],
    );

    _initDistanceAndTime();
    _initPolyline();
  }

  void onTapPolyline(int index) {
    widget.args.onChangeSelectedRoute?.call(index);
  }

  renderMarker() {
    MarkerGenerator(markerWidgets(), (List<Uint8List> bitmaps) {
      if (mounted) {
        setState(() {
          markers = mapBitmapsToMarkers(bitmaps);
        });
      }
    }).generate(context);
  }

  List<Widget> markerWidgets() {
    return List<Widget>.generate(
      locationList.length,
      (int index) => _locationMarker(locationList[index], index),
    );
  }

  Map<MarkerId, Marker> mapBitmapsToMarkers(List<Uint8List> bitmaps) {
    Map<MarkerId, Marker> markersList = <MarkerId, Marker>{};
    bitmaps.asMap().forEach((int i, Uint8List bmp) {
      MarkerId markerId = MarkerId('marker_$i');
      Marker marker = Marker(
        markerId: markerId,
        icon: BitmapDescriptor.fromBytes(bmp),
        position: LatLng(
          locationList[i].latitude ?? 0,
          locationList[i].longitude ?? 0,
        ),
      );
      markersList[markerId] = marker;
    });
    return markersList;
  }

  @override
  void didUpdateWidget(MapRouteBooking oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.args.locations != widget.args.locations) {
      locationList = List<LocationRequest>.from(widget.args.locations);
    }
    if (oldWidget.args.listRouteOptions != widget.args.listRouteOptions) {
      listRouteOptions = List<TotalDirectionResultModel>.from(
        widget.args.listRouteOptions ?? <TotalDirectionResultModel>[],
      );
      _initDistanceAndTime();
      _initPolyline();
    }
  }

  _initDistanceAndTime() {
    if (listRouteOptions.isNotEmpty == true) {
      distance = DistanceUtil.convertMeterToKm(
        listRouteOptions[defaultSelectedRoute].totalDistance ?? 0,
      );
      duration = TimeUtil.convertSecondToMinute(
        listRouteOptions[defaultSelectedRoute].totalDuration?.toInt() ?? 0,
      );
    } else {
      distance = 0;
      duration = 0;
    }
  }

  _initPolyline() {
    if (locationList.length == minDestinationLength) {
      // Many options, each option has just 1 direction from Start to End
      polylines = List<Polyline>.generate(listRouteOptions.length, (int index) {
        return listRouteOptions[index]
            .routeOptions!
            .first // each option has only one directions
            .polyline!
            .copyWithNewId(
              widthParam: 6.w.toInt(),
              colorParam: index == defaultSelectedRoute
                  ? ColorsConstant.cFFA33AA3
                  : ColorsConstant.cFFAEB0BF,
              onTapParam: index != defaultSelectedRoute
                  ? () {
                      onTapPolyline(index);
                    }
                  : null,
            );
      }).toSet();
    } else {
      // Just one options, has many directions from A -> B -> C -> ... -> End
      List<Polyline> listPolylines = <Polyline>[];
      for (TotalDirectionResultModel element in listRouteOptions) {
        List<Polyline> subPolylines = element.routeOptions!
            .map(
              (DirectionResultModel e) => e.polyline!.copyWithNewId(
                widthParam: 6.w.toInt(),
                colorParam: ColorsConstant.cFFA33AA3,
                onTapParam: null,
              ),
            )
            .toList();
        listPolylines.addAll(subPolylines);
      }
      polylines = listPolylines.toSet();
    }
  }

  final NumberFormat formatter = NumberFormat('#.#');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SizedBox(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                GoogleMap(
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                    Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer(),
                    ),
                  },
                  onMapCreated: _onMapCreated,
                  polylines: Set<Polyline>.from(polylines.toList().reversed),
                  markers: Set<Marker>.of(markers.values),
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      locationList.first.latitude ?? 0,
                      locationList.first.longitude ?? 0,
                    ),
                  ),
                  mapType: MapType.normal,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30.h,
            right: 10.w,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.w),
              decoration: const BoxDecoration(
                color: ColorsConstant.cWhite,
              ),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset(
                    SvgAssets.icTimeTravelMap,
                    height: 16.w,
                    width: 16.w,
                  ),
                  Text(
                    '$duration ${S(context).minute}',
                    style: StylesConstant.ts14w400
                        .copyWith(color: ColorsConstant.cFFA33AA3),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Text(
                      '•',
                      style: StylesConstant.ts14w400
                          .copyWith(color: ColorsConstant.cFFA33AA3),
                    ),
                  ),
                  SvgPicture.asset(
                    SvgAssets.icDirectionMap,
                    height: 16.w,
                    width: 16.w,
                  ),
                  Text(
                    '${formatter.format(distance)} ${S(context).km}.',
                    style: StylesConstant.ts14w400
                        .copyWith(color: ColorsConstant.cFFA33AA3),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _locationMarker(LocationRequest location, int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _nameLocationTag(location.addressName ?? ''),
        SizedBox(
          height: 6.w,
        ),
        if (index == 0)
          CircleAvatar(
            radius: (35 / 2).w,
            backgroundColor: ColorsConstant.cFFFCF4D9,
            child: CircleAvatar(
              radius: (17.5 / 2).w,
              backgroundColor: ColorsConstant.cFFF2C94C,
            ),
          )
        else
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              SvgPicture.asset(
                SvgAssets.icLocationFill,
                height: 40.w,
                width: 40.w,
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.w),
                child: CircleAvatar(
                  radius: 10.w,
                  backgroundColor: Colors.white,
                  child: Text(
                    index.toString(),
                    style: StylesConstant.ts16wBold.copyWith(
                      color: ColorsConstant.cFFA33AA3,
                    ),
                  ),
                ),
              )
            ],
          ),
      ],
    );
  }

  Widget _nameLocationTag(String name) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 12.w),
      decoration: const BoxDecoration(color: ColorsConstant.cWhite),
      child: Text(
        name,
        style: StylesConstant.ts14w400.copyWith(
          color: ColorsConstant.cFFA33AA3,
        ),
      ),
    );
  }

  _onMapCreated(GoogleMapController controller) {
    if (mounted) {
      setState(() {
        googleMapController = controller;
      });
      if (locationList.isNotEmpty) {
        _setMapFitToMap();
      }
    }
  }

  Future<void> _setMapFitToMap() async {
    double minLat = locationList.first.latitude ?? 0;
    double minLong = locationList.first.longitude ?? 0;
    double maxLat = locationList.first.latitude ?? 0;
    double maxLong = locationList.first.longitude ?? 0;
    if (polylines.isNotEmpty) {
      minLat = polylines.first.points.first.latitude;
      minLong = polylines.first.points.first.longitude;
      maxLat = polylines.first.points.first.latitude;
      maxLong = polylines.first.points.first.longitude;
      for (Polyline poly in polylines) {
        for (LatLng point in poly.points) {
          if (point.latitude < minLat) minLat = point.latitude;
          if (point.latitude > maxLat) maxLat = point.latitude;
          if (point.longitude < minLong) minLong = point.longitude;
          if (point.longitude > maxLong) maxLong = point.longitude;
        }
      }
    } else {
      for (LocationRequest locationReq in locationList) {
        if (locationReq.latitude == null || locationReq.longitude == null) {
          break;
        }

        if (locationReq.latitude! < minLat) {
          minLat = locationReq.latitude!;
        }
        if (locationReq.longitude! < minLong) {
          minLong = locationReq.longitude!;
        }
        if (locationReq.latitude! > maxLat) {
          maxLat = locationReq.latitude!;
        }
        if (locationReq.longitude! > maxLong) {
          maxLong = locationReq.longitude!;
        }
      }
    }

    await googleMapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(
            minLat + recenterSouthSideMapBooking,
            minLong + recenterSouthSideMapBooking,
          ),
          northeast: LatLng(
            maxLat + recenterNorthSideMapBooking,
            maxLong + recenterNorthSideMapBooking,
          ),
        ),
        initialZoomLevelBooking,
      ),
    );
  }
}
