import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/location/data/repo/current_location_repo.dart';
import 'package:passenger/features/map_page/data/model/list_car_by_location_model.dart';
import 'package:passenger/features/map_page/data/repo/map_page_repo.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/enum.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:passenger/util/util.dart';

part 'map_page_event.dart';
part 'map_page_state.dart';

@injectable
class MapPageBloc extends Bloc<MapPageEvent, MapPageState> {
  MapPageBloc(this._mapPageRepo, this._currentLocationRepo)
      : super(const MapPageState(stateMap: LoadState.loading)) {
    on<GetLocationCurrentEvent>(_getLocationCurrent);

    on<GetListCarEvent>(_getListCarByCurrentLocation);
  }

  final MapPageRepo _mapPageRepo;
  final CurrentLocationRepo _currentLocationRepo;
  Map<MarkerId, Marker> markersListCar = <MarkerId, Marker>{};
  Map<MarkerId, Marker> markersCurrentLocation = <MarkerId, Marker>{};

  void _getLocationCurrent(
    GetLocationCurrentEvent event,
    Emitter<MapPageState> emit,
  ) async {
    emit(
      state.copyWith(
        stateMap: LoadState.loading,
      ),
    );

    Position? position = await _currentLocationRepo.getCurrentPosition();

    if (position != null) {
      await addCurrentLocation(
        LatLng(position.latitude, position.longitude),
      );

      emit(
        state.copyWith(
          position: position,
          stateMap: LoadState.success,
          markersCurrentLocation: markersCurrentLocation,
        ),
      );
    } else {
      emit(
        state.copyWith(
          stateMap: LoadState.failure,
        ),
      );
    }
  }

  Future<void> addListDriver(List<CarItem> listCar) async {
    for (CarItem item in listCar) {
      int index = listCar.indexOf(item);
      double valueFakeRotation = 20.0 * index;
      LatLng latLng = LatLng(
        double.tryParse(item.latitude.toString()) ?? 0.0,
        double.tryParse(item.longitude.toString()) ?? 0.0,
      );
      await _addMarker(
        latLng,
        PngAssets.icCar,
        rotation: valueFakeRotation,
        markers: markersListCar,
      );
    }
  }

  Future<void> addCurrentLocation(LatLng latLng) async {
    await _addMarker(
      latLng,
      PngAssets.icLocationCurrent,
      markers: markersCurrentLocation,
    );
  }

  Future<void> _addMarker(
    LatLng latLng,
    String iconPath, {
    double? rotation,
    required Map<MarkerId, Marker> markers,
  }) async {
    final Uint8List markerIcon = await getBytesFromAsset(iconPath, 120);
    final MarkerId idMarker = MarkerId('${latLng.latitude}_${latLng.latitude}');
    final Marker marker = markers[idMarker] = Marker(
      markerId: idMarker,
      rotation: rotation ?? 0.0,
      position: LatLng(
        latLng.latitude,
        latLng.longitude,
      ),
      anchor: const Offset(0.5, 0.5),
      icon: BitmapDescriptor.fromBytes(markerIcon),
      infoWindow: const InfoWindow(),
      onTap: () {
        // _onMarkerTapped(markerId);
      },
    );
    markers[idMarker] = marker;
  }

  FutureOr<void> _getListCarByCurrentLocation(
    GetListCarEvent event,
    Emitter<MapPageState> emit,
  ) async {
    emit(
      state.copyWith(
        stateListCar: LoadState.loading,
      ),
    );
    Position? position = await _currentLocationRepo.getCurrentPosition();

    if (position != null) {
      DataState<ListCarByLocationModel> listCarModel =
          await _mapPageRepo.getListCarLocation(
        distance: radiusDriverMeter,
        desLat: 0,
        desLng: 0,
        depLat: position.latitude,
        depLng: position.longitude,
      );

      await addListDriver(listCarModel.data?.data ?? <CarItem>[]);

      emit(
        state.copyWith(
          position: position,
          stateListCar: LoadState.success,
          markersListCard: markersListCar,
        ),
      );
    } else {
      state.copyWith(
        stateListCar: LoadState.failure,
      );
    }
  }
}
