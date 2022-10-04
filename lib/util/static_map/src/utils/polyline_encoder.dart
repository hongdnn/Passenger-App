part of google_static_maps_controller;

class PolylineEncoder {
  const PolylineEncoder._();

  static const int _questionMarkCharCode = 63;

  static String encodePath(List<Location> path) {
    Location start = const Location(0, 0);
    final StringBuffer output = StringBuffer();
    for (final Location location in path) {
      final Location diff = location - start;
      encode(diff.latitude, output);
      encode(diff.longitude, output);
      start = location;
    }

    return output.toString();
  }

  static String encode(final double value, [StringBuffer? buffer]) {
    // The value must be multiplied by 1e5
    const int factor = 100000;

    int transformedValue = (value * factor).round();
    int binary = transformedValue << 1;
    binary = value.isNegative ? ~binary : binary;

    final StringBuffer output = buffer ?? StringBuffer();

    while (binary >= 0x20) {
      output.write(
        String.fromCharCode((0x20 | (binary & 0x1f)) + _questionMarkCharCode),
      );
      binary = binary >> 5;
    }
    output.write(String.fromCharCode(binary + _questionMarkCharCode));

    return output.toString();
  }
}
