import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/static_map/google_static_maps_controller.dart';
import 'package:passenger/util/string_constant.dart';
import 'package:passenger/util/util.dart';

class MiniMapWidget extends StatelessWidget {
  const MiniMapWidget({
    Key? key,
    required this.tripLocation,
  }) : super(key: key);
  final List<TripLocation> tripLocation;

  @override
  Widget build(BuildContext context) {
    List<Polyline> listPolyline = <Polyline>[];
    if (tripLocation.length < minDestinationLength) {
      return const SizedBox();
    }
    for (int i = 1; i < tripLocation.length; ++i) {
      listPolyline.add(
        Polyline(
          polylineId: PolylineId(i.toString()),
          points: decodeEncodedPolyline(
            tripLocation[i].pathToLocation!,
          ),
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        color: ColorsConstant.cWhite,
        height: 200.h,
        child: StaticMap(
          width: double.infinity,
          height: 200.h,
          scaleToDevicePixelRatio: true,
          googleApiKey: keyGGApi,
          paths: List<Path>.generate(listPolyline.length, (int index) {
            return Path(
              encoded: true,
              points: List<Location>.generate(
                listPolyline.toList()[index].points.length,
                (int idx) => Location(
                  listPolyline[index].points[idx].latitude,
                  listPolyline[index].points[idx].longitude,
                ),
              ),
              color: ColorsConstant.cFFA33AA3,
            );
          }),
          markers: List<MarkerRH>.generate(tripLocation.length, (int index) {
            if (index == 0) {
              return MarkerRH.custom(
                icon: StringConstant.markerUrlImages[index],
                locations: <Location>[
                  Location(
                    tripLocation[index].latitude ?? 0,
                    tripLocation[index].longitude ?? 0,
                  ),
                ],
              );
            } else {
              return MarkerRH.custom(
                icon: tripLocation.length == minDestinationLength
                    ? StringConstant.markerUrlForOneDes
                    : StringConstant.markerUrlImages[index],
                locations: <Location>[
                  Location(
                    tripLocation[index].latitude ?? 0,
                    tripLocation[index].longitude ?? 0,
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}
