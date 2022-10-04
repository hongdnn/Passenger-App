part of 'map_page_bloc.dart';

@immutable
class MapPageState {
  const MapPageState({
    this.markersListCard,
    this.markersCurrentLocation,
    this.stateMap,
    this.stateListCar,
    this.position,
  });

  final LoadState? stateMap;
  final LoadState? stateListCar;
  final Position? position;
  final Map<MarkerId, Marker>? markersListCard;
  final Map<MarkerId, Marker>? markersCurrentLocation;

  MapPageState copyWith({
    LoadState? stateMap,
    LoadState? stateListCar,
    Position? position,
    Map<MarkerId, Marker>? markersListCard,
    Map<MarkerId, Marker>? markersCurrentLocation,
  }) {
    return MapPageState(
      stateMap: stateMap ?? this.stateMap,
      stateListCar: stateListCar ?? this.stateListCar,
      position: position ?? this.position,
      markersListCard: markersListCard ?? this.markersListCard,
      markersCurrentLocation:
          markersCurrentLocation ?? this.markersCurrentLocation,
    );
  }
}
