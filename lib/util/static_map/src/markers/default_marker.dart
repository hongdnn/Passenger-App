part of google_static_maps_controller;

class DefaultMarker extends MarkerRH {
  const DefaultMarker({
    required List<GeocodedLocation> locations,
    this.color,
    this.size,
    this.label,
  })  : assert(
          label == null || label.length == 1,
          'Label can have only one letter',
        ),
        super._(locations);
  final Color? color;
  final MarkerSize? size;
  final String? label;

  @override
  String toUrlString() {
    if (locations.isEmpty) {
      throw StateError(
        'Marker must contain at least one location. '
        'Empty array was provided to "locations" argument.',
      );
    }

    String string = '';

    final String? markerSize = size?.value;
    if (markerSize != null) string += 'size:$markerSize$_separator';

    if (label != null) {
      string += 'label:${label![0].toUpperCase()}$_separator';
    }

    if (color != null) {
      string += 'color:${color!.to24BitHexString()}$_separator';
    }

    if (locations.isNotEmpty) {
      string += _markerLocationsString;
    }

    return string;
  }
}
