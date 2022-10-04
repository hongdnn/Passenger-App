import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/features/map_page/presentation/map_page/bloc/map_page_bloc.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/enum.dart';

import 'package:passenger/util/styles.dart';

import 'package:passenger/core/util/localization.dart';

class MapTrackingDriverWidget extends StatefulWidget {
  const MapTrackingDriverWidget({Key? key}) : super(key: key);
  static const String routeName = '/mapPage';

  @override
  State<MapTrackingDriverWidget> createState() =>
      _MapTrackingDriverWidgetState();
}

class _MapTrackingDriverWidgetState extends State<MapTrackingDriverWidget> {
  late GoogleMapController controller;
  late MapPageBloc _mapPageBloc;
  late Set<Circle> circles;
  late LatLng centerLcation = const LatLng(0, 0);

  @override
  void initState() {
    _mapPageBloc = getIt();
    _mapPageBloc.add(GetLocationCurrentEvent());
    _mapPageBloc.add(GetListCarEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapPageBloc>(
      create: (BuildContext context) => _mapPageBloc,
      child: BlocConsumer<MapPageBloc, MapPageState>(
        listener: (BuildContext context, MapPageState state) {
          if (state.stateMap == LoadState.success) {
            centerLcation = LatLng(
              state.position?.latitude ?? 0,
              state.position?.longitude ?? 0,
            );

            circles = <Circle>{
              _buildCricle(radius: 800),
              _buildCricle(radius: 400),
              _buildCricle(radius: 200),
            };
          }
        },
        builder: (BuildContext context, MapPageState state) {
          if (state.stateMap == LoadState.success) {
            return GoogleMap(
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
                ),
              },
              circles: circles,
              myLocationButtonEnabled: false,
              onMapCreated: _onMapCreated,
              markers: (state.markersListCard?.values ?? <Marker>[]).toSet(),
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  state.position?.latitude ?? 0,
                  state.position?.longitude ?? 0,
                ),
                zoom: 15,
              ),
              zoomControlsEnabled: false,
              zoomGesturesEnabled: false,
              mapType: MapType.normal,
            );
          } else if (state.stateMap == LoadState.loading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return Center(
            child: Text(
              S(context).map_error,
              style: StylesConstant.ts16w500,
            ),
          );
        },
      ),
    );
  }

  Circle _buildCricle({
    required double radius,
  }) {
    return Circle(
      circleId: CircleId('id_$double'),
      center: centerLcation,
      radius: radius,
      strokeWidth: 0,
      fillColor: ColorsConstant.cFFABADBA.withOpacity(0.15),
    );
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    if (mounted) {
      setState(() {
        controller = controllerParam;
      });
    }
  }
}
