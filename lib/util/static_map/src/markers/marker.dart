part of google_static_maps_controller;

abstract class MarkerRH implements EncodableUrlPart {
  const MarkerRH._(this.locations);

  /// Create default google maps style marker
  const factory MarkerRH({
    required List<GeocodedLocation> locations,
    Color? color,
    MarkerSize? size,
    String? label,
  }) = DefaultMarker;

  /// Create marker with custom icon
  const factory MarkerRH.custom({
    required List<Location> locations,
    required String icon,
    MarkerAnchor? anchor,
  }) = CustomMarker;

  final List<GeocodedLocation> locations;

  String get _markerLocationsString {
    List<String> parts = List<String>.generate(
      locations.length,
      (int index) => locations[index].toUrlString(),
    );
    return parts.join(_separator);
  }
}
