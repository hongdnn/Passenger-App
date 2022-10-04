part of google_static_maps_controller;

class _StyleAdministrative extends StyleFeature {
  const _StyleAdministrative() : super._('administrative');

  /// Selects countries.
  final StyleFeature country = const StyleFeature._('administrative.country');

  /// Selects land parcels.
  final StyleFeature landParcel =
      const StyleFeature._('administrative.land_parcel');

  /// Selects localities.
  final StyleFeature locality = const StyleFeature._('administrative.locality');

  /// Selects neighborhoods.
  final StyleFeature neighborhood =
      const StyleFeature._('administrative.neighborhood');

  /// Selects provinces.
  final StyleFeature province = const StyleFeature._('administrative.province');
}

class _StyleLandscapeNatural extends StyleFeature {
  const _StyleLandscapeNatural() : super._('landscape.natural');

  final StyleFeature landcover =
      const StyleFeature._('landscape.natural.landcover');

  final StyleFeature terrain =
      const StyleFeature._('landscape.natural.terrain');
}

class _StyleLandscape extends StyleFeature {
  const _StyleLandscape() : super._('landscape');

  /// Selects man-made features, such as buildings and other structures.
  final StyleFeature manMade = const StyleFeature._('landscape.man_made');

  final _StyleLandscapeNatural natural = const _StyleLandscapeNatural();
}

class _StylePoi extends StyleFeature {
  const _StylePoi() : super._('poi');

  /// Selects tourist attractions.
  final StyleFeature attraction = const StyleFeature._('poi.attraction');

  /// Selects businesses.
  final StyleFeature business = const StyleFeature._('poi.business');

  /// Selects government buildings.
  final StyleFeature government = const StyleFeature._('poi.government');

  final StyleFeature medical = const StyleFeature._('poi.medical');

  /// Selects parks.
  final StyleFeature park = const StyleFeature._('poi.park');

  final StyleFeature placeOfWorship =
      const StyleFeature._('poi.place_of_worship');

  /// Selects schools.
  final StyleFeature school = const StyleFeature._('poi.school');

  /// Selects sports complexes.
  final StyleFeature sportsComplex = const StyleFeature._('poi.sports_complex');
}

class _StyleRoadHighway extends StyleFeature {
  const _StyleRoadHighway() : super._('road.highway');

  /// Selects highways with controlled access.
  final StyleFeature controlledAccess =
      const StyleFeature._('landscape.natural.controlled_access');
}

class _StyleRoad extends StyleFeature {
  const _StyleRoad() : super._('road');

  /// Selects arterial roads.
  final StyleFeature arterial = const StyleFeature._('road.arterial');

  /// Selects highways.
  final _StyleRoadHighway highway = const _StyleRoadHighway();

  /// Selects local roads.
  final StyleFeature local = const StyleFeature._('road.local');
}

class _StyleTransitStation extends StyleFeature {
  const _StyleTransitStation() : super._('transit.station');

  /// Selects airports.
  final StyleFeature airport = const StyleFeature._('transit.station.airport');

  /// Selects bus stops.
  final StyleFeature bus = const StyleFeature._('transit.station.bus');

  /// Selects rail stations.
  final StyleFeature rail = const StyleFeature._('transit.station.rail');
}

class _StyleTransit extends StyleFeature {
  const _StyleTransit() : super._('transit');

  /// Selects transit lines.
  final StyleFeature line = const StyleFeature._('transit.line');

  /// Selects all transit stations.
  final _StyleTransitStation station = const _StyleTransitStation();
}

class StyleFeature {
  const StyleFeature._(this.value);
  final String value;

  /// Selects all features.
  static const StyleFeature all = StyleFeature._('all');

  // ignore: library_private_types_in_public_api
  static const _StyleAdministrative administrative = _StyleAdministrative();

  /// Selects all landscapes.
  // ignore: library_private_types_in_public_api
  static const _StyleLandscape landscape = _StyleLandscape();

  /// Selects all points of interest.
  // ignore: library_private_types_in_public_api
  static const _StylePoi poi = _StylePoi();

  /// Selects all roads.
  // ignore: library_private_types_in_public_api
  static const _StyleRoad road = _StyleRoad();

  /// Selects all transit stations and lines.
  // ignore: library_private_types_in_public_api
  static const _StyleTransit transit = _StyleTransit();

  /// selects bodies of water.
  static const StyleFeature water = StyleFeature._('water');
}
