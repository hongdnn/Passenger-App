part of google_static_maps_controller;

abstract class StyleRule implements EncodableUrlPart {
  const StyleRule();

  const factory StyleRule.hue(Color hue) = _StyleHueRule;

  const factory StyleRule.lightness(int lightness) = _StyleLightnessRule;

  const factory StyleRule.saturation(int saturation) = _StyleSaturationRule;

  const factory StyleRule.gamma(double gamma) = _StyleGammaRule;

  const factory StyleRule.invertLightness(bool invertLightness) =
      _StyleInvertLightnessRule;

  const factory StyleRule.visibility(VisibilityRule visibility) =
      _StyleVisibilityRule;

  /// sets the color of the feature.
  const factory StyleRule.color(Color color) = _StyleColorRule;

  const factory StyleRule.weight(int weight) = _StyleWeightRule;

  String get key;
  String get value;

  @override
  String toUrlString() => '$key:$value';

  @override
  String toString() => '$runtimeType($key, $value)';
}

class _StyleHueRule extends StyleRule {
  const _StyleHueRule(this.hue);
  final Color hue;

  @override
  String get key => 'hue';
  @override
  String get value => hue.to24BitHexString();
}

class _StyleColorRule extends StyleRule {
  const _StyleColorRule(this.color);
  final Color color;

  @override
  String get key => 'color';
  @override
  String get value => color.to24BitHexString();
}

class _StyleLightnessRule extends StyleRule {
  const _StyleLightnessRule(this.lightness)
      : assert(
          lightness >= -100 && lightness <= 100,
          'lightness argument must be in range -100 to 100',
        );
  final int lightness;

  @override
  String get key => 'lightness';
  @override
  String get value => lightness.toString();
}

class _StyleSaturationRule extends StyleRule {
  const _StyleSaturationRule(this.saturation)
      : assert(
          saturation >= -100 && saturation <= 100,
          'saturation argument must be in range -100 to 100',
        );
  final int saturation;

  @override
  String get key => 'saturation';
  @override
  String get value => saturation.toString();
}

class _StyleWeightRule extends StyleRule {
  const _StyleWeightRule(this.weight)
      : assert(
          weight >= 0,
          'weight argument should be greater than or equal to zero',
        );
  final int weight;

  @override
  String get key => 'weight';
  @override
  String get value => weight.toString();
}

class _StyleGammaRule extends StyleRule {
  const _StyleGammaRule(this.gamma)
      : assert(
          gamma >= 0.01 && gamma <= 10.0,
          'gamma argument must be in range 0.01 to 10.0',
        );
  final double gamma;

  @override
  String get key => 'gamma';
  @override
  String get value => gamma.toString();
}

class _StyleInvertLightnessRule extends StyleRule {
  const _StyleInvertLightnessRule(this.invertLightness);
  final bool invertLightness;

  @override
  String get key => 'invert_lightness';
  @override
  String get value => invertLightness.toString();
}

class _StyleVisibilityRule extends StyleRule {
  const _StyleVisibilityRule(this.visibility);
  final VisibilityRule visibility;

  @override
  String get key => 'visibility';
  @override
  String get value => visibility.value;
}

class MapStyle implements EncodableUrlPart {
  const MapStyle({
    this.element,
    this.feature,
    required this.rules,
  });
  final StyleFeature? feature;
  final StyleElement? element;

  final List<StyleRule> rules;

  String _rulesUrlString() {
    final List<String> parts = List<String>.generate(
      rules.length,
      (int index) => rules[index].toUrlString(),
    );

    return parts.join(_separator);
  }

  @override
  String toUrlString() {
    String url = '';
    if (feature != null) url += 'feature:${feature!.value}$_separator';
    if (element != null) url += 'element:${element!.value}$_separator';
    url += _rulesUrlString();
    return url;
  }
}
