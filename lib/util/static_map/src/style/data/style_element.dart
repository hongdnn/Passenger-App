part of google_static_maps_controller;

class _StyleElementGeometry extends StyleElement {
  const _StyleElementGeometry() : super._('geometry');

  /// selects only the fill of the feature's geometry.
  final StyleElement fill = const StyleElement._('geometry.fill');

  /// selects only the stroke of the feature's geometry.
  final StyleElement stroke = const StyleElement._('geometry.stroke');
}

class _StyleElementLabelsText extends StyleElement {
  const _StyleElementLabelsText() : super._('labels.text');

  final StyleElement fill = const StyleElement._('labels.text.fill');

  /// selects only the stroke of the label's text
  final StyleElement stroke = const StyleElement._('labels.text.stroke');
}

class _StyleElementLabels extends StyleElement {
  const _StyleElementLabels() : super._('labels');

  /// selects only the icon displayed within the feature's label
  final StyleElement icon = const StyleElement._('labels.icon');

  /// selects only the text of the label
  final _StyleElementLabelsText text = const _StyleElementLabelsText();
}

class StyleElement {
  const StyleElement._(this.value);
  final String value;

  /// selects all elements of the specified feature.
  static const StyleElement all = StyleElement._('all');

  /// selects all geometric elements of the specified feature.
  // ignore: library_private_types_in_public_api
  static const _StyleElementGeometry geometry = _StyleElementGeometry();

  /// selects the textual labels associated with the specified feature
  // ignore: library_private_types_in_public_api
  static const _StyleElementLabels labels = _StyleElementLabels();
}
