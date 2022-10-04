part of google_static_maps_controller;

class MarkerAnchor {
  const MarkerAnchor._predefined(this.value);

  const MarkerAnchor(int x, int y) : value = '$x, $y';
  final String value;

  static const MarkerAnchor top = MarkerAnchor._predefined('top');
  static const MarkerAnchor bottom = MarkerAnchor._predefined('bottom');
  static const MarkerAnchor left = MarkerAnchor._predefined('left');
  static const MarkerAnchor right = MarkerAnchor._predefined('right');
  static const MarkerAnchor center = MarkerAnchor._predefined('center');
  static const MarkerAnchor topLeft = MarkerAnchor._predefined('topleft');
  static const MarkerAnchor topRight = MarkerAnchor._predefined('topright');
  static const MarkerAnchor bottomLeft = MarkerAnchor._predefined('bottomleft');
  static const MarkerAnchor bottomRight =
      MarkerAnchor._predefined('bottomright');
}
