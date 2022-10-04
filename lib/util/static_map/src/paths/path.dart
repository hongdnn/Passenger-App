part of google_static_maps_controller;

/// The path class defines a set of one or more locations
/// connected by a path to overlay on the map image.
abstract class Path implements EncodableUrlPart {
  const Path._internal({
    required this.encoded,
    this.weight,
    this.color,
    this.fillColor,
    this.geodesic,
  });

  /// Draws a circle path.
  const factory Path.circle({
    required Location center,
    required int radius,
    int detail,
    bool encoded,
    int? weight,
    Color? color,
    Color? fillColor,
    bool? geodesic,
  }) = CirclePath;

  /// Draws a path from the provided encoded polyline string.
  const factory Path.encodedPolyline(
    String encodedPolyline, {
    int? weight,
    Color? color,
    Color? fillColor,
    bool? geodesic,
  }) = EncodedPath;

  /// Draws a path
  const factory Path({
    required List<GeocodedLocation> points,
    bool encoded,
    int? weight,
    Color? color,
    Color? fillColor,
    bool? geodesic,
  }) = _Path;

  /// (optional) specifies the thickness of the path in pixels.
  /// If no weight parameter is set, the path will appear in its
  /// default thickness (5 pixels).
  final int? weight;

  /// (optional) Specifies a path color;
  final Color? color;

  /// (optional) indicates both that the path marks off a polygonal
  /// area and specifies the fill color to use as an overlay within
  /// that area. The set of locations following need not be a "closed"
  /// loop; the Maps Static API server will automatically join the
  /// first and last points. Note, however, that any stroke on the
  /// exterior of the filled area will not be closed unless you
  /// specifically provide the same beginning and end location.
  final Color? fillColor;

  /// (optional) indicates that the requested path should be
  /// interpreted as a geodesic line that follows the curvature of
  /// the earth. When false, the path is rendered as a straight
  /// line in screen space. Defaults to false.
  final bool? geodesic;

  /// In order to draw a path, the path class must also be passed
  /// two or more points. The Maps Static API will then connect the
  /// path along those points, in the specified order.
  ///
  /// When [Path.circle] constructor is used, points will be calculated
  /// based on the `radius`, `center` and optional `detail` parameters.
  List<GeocodedLocation> get points;

  /// Setting this value to true enables a
  /// [polyline encoding](https://developers.google.com/maps/documentation/utilities/polylinealgorithm)
  ///
  /// It is a lossy compression algorithm that allows you
  /// to store a series of coordinates as a single string.
  /// Point coordinates are encoded using signed values.
  final bool encoded;

  bool get hasAddressPoints =>
      points.any((GeocodedLocation point) => point is AddressLocation);

  List<String> _getBaseUrlStringParts() {
    List<String> parts = <String>[];

    if (weight != null) parts.add('weight:$weight');
    if (color != null) parts.add('color:${color!.to32BitHexString()}');
    if (geodesic != null) parts.add('geodesic:$geodesic');
    if (fillColor != null) {
      parts.add('fillcolor:${fillColor!.to32BitHexString()}');
    }

    return parts;
  }

  @override
  String toUrlString() {
    // if (points.length < 2) {
    //   throw StateError(
    //     'In order to draw a path, the path '
    //     'points.length=${points.length}',
    //   );
    // }

    final List<String> parts = _getBaseUrlStringParts();

    assert(
      !encoded || encoded && !hasAddressPoints,
      'Cannot encode path using polyline encoding when address locations '
      'are defined. Use Location (GeocodedLocation.latLng) '
      'instead of AddressLocation (GeocodedLocation.address) class.',
    );

    if (encoded && !hasAddressPoints) {
      parts.add('enc:${PolylineEncoder.encodePath(points.cast<Location>())}');
    } else {
      for (final GeocodedLocation location in points) {
        parts.add(location.toUrlString());
      }
    }

    return parts.join(_separator);
  }
}

class CirclePath extends Path {
  const CirclePath({
    required this.center,
    required this.radius,
    this.detail = 45,
    bool encoded = false,
    int? weight,
    Color? color,
    Color? fillColor,
    bool? geodesic,
  }) : super._internal(
          encoded: encoded,
          color: color,
          weight: weight,
          fillColor: fillColor,
          geodesic: geodesic,
        );

  /// The center of the circle.
  final Location center;

  /// Circle radius in meters.
  ///
  /// In order to render a circle, make sure to provide only one
  /// path point.
  ///
  /// This is not a part of the official google static maps API,
  /// but a useful addition that simplifies drawing circles.
  final int radius;

  /// The number of [points] that will be generated to describe the circle.
  /// The actual number of points is `detail + 1` because the last point
  /// will be the same as the first.
  ///
  /// #### IMPORTANT:
  /// - Must be greater than or equal to 4.
  /// - `360 % detail` must be 0.
  final int detail;

  @override
  List<Location> get points {
    if (detail < 4) {
      throw StateError(
        'At least the detail of 4 is required to draw a circle.',
      );
    } else if (360 % detail != 0) {
      throw StateError(
        'The remainder when dividing 360 by detail must be 0. '
        'Current reminder of 360 % $detail equals ${360 % 8} which is not 0.',
      );
    }

    const int R = 6371;

    final double lat = (center.latitude * pi) / 180;
    final double lng = (center.longitude * pi) / 180;
    final double d = (radius / 1000) / R;

    final List<Location> path = <Location>[];

    final int step = 360 ~/ detail;

    for (int i = 0; i < 360; i += step) {
      final double brng = (i * pi) / 180;

      double plat = asin(sin(lat) * cos(d) + cos(lat) * sin(d) * cos(brng));
      double plng = ((lng +
                  atan2(
                    sin(brng) * sin(d) * cos(lat),
                    cos(d) - sin(lat) * sin(plat),
                  )) *
              180) /
          pi;
      plat = (plat * 180) / pi;

      path.add(Location(plat, plng));
    }

    /// Close the circle.
    path.add(path.first);

    return path;
  }
}

class _Path extends Path {
  const _Path({
    required this.points,
    bool encoded = false,
    int? weight,
    Color? color,
    Color? fillColor,
    bool? geodesic,
  }) : super._internal(
          encoded: encoded,
          color: color,
          weight: weight,
          fillColor: fillColor,
          geodesic: geodesic,
        );
  @override
  final List<GeocodedLocation> points;
}

class EncodedPath extends Path {
  const EncodedPath(
    this.encodedPolyline, {
    int? weight,
    Color? color,
    Color? fillColor,
    bool? geodesic,
  }) : super._internal(
          encoded: true,
          color: color,
          weight: weight,
          fillColor: fillColor,
          geodesic: geodesic,
        );
  @override
  List<Location> get points {
    throw UnimplementedError(
      'Currently points getter is not supported for predefined polylines.',
    );
  }

  /// Encoded polyline string
  final String encodedPolyline;

  @override
  String toUrlString() {
    if (encodedPolyline.isEmpty) {
      throw StateError('Encoded polyline cannot be empty.');
    }
    final List<String> parts = _getBaseUrlStringParts()
      ..add('enc:$encodedPolyline');
    return parts.join(_separator);
  }
}
