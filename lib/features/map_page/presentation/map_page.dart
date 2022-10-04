import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/features/map_page/presentation/map_page/bloc/map_page_bloc.dart';
import 'package:passenger/util/enum.dart';

import 'package:passenger/util/styles.dart';

import 'package:passenger/core/util/localization.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);
  static const String routeName = '/mapPage';

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController controller;
  late Set<Circle> circles;
  late LatLng centerLcation = const LatLng(0, 0);

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<MapPageBloc>(context).add(GetLocationCurrentEvent());
      BlocProvider.of<MapPageBloc>(context).add(GetListCarEvent());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapPageBloc, MapPageState>(
      listener: (BuildContext context, MapPageState state) {
        if (state.stateMap == LoadState.success) {
          centerLcation = LatLng(
            state.position?.latitude ?? 0,
            state.position?.longitude ?? 0,
          );
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
            myLocationButtonEnabled: false,
            onMapCreated: _onMapCreated,
            markers: <Marker>{
              ...(state.stateListCar == LoadState.success
                  ? state.markersListCard!.values.toSet()
                  : <Marker>{}),
              ...(state.stateMap == LoadState.success
                  ? state.markersCurrentLocation!.values.toSet()
                  : <Marker>{}),
            },
            initialCameraPosition: CameraPosition(
              target: state.stateMap == LoadState.success
                  ? LatLng(
                      state.position!.latitude,
                      state.position!.longitude,
                    )
                  : const LatLng(
                      0,
                      0,
                    ),
              zoom: zoomMap,
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
    );
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
    });
  }
}
