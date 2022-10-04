part of google_static_maps_controller;

/// Widget for displaying static map. It uses `Image.network` widget.
class StaticMap extends StatelessWidget {
  const StaticMap({
    Key? key,
    required this.googleApiKey,
    this.width,
    this.height,
    this.markers,
    this.visible,
    this.center,
    this.zoom,
    this.scale,
    this.format,
    this.maptype,
    this.mapId,
    this.paths,
    this.language,
    this.region,
    this.signature,
    this.styles,
    this.scaleToDevicePixelRatio = true,
  }) : super(key: key);
  final String? mapId;
  final List<MarkerRH>? markers;
  final List<MapStyle>? styles;
  final List<Path>? paths;

  /// (optional) specifies one or more locations that should remain visible
  /// on the map, though no markers or other indicators will be displayed.
  /// Use this parameter to ensure that certain features or map locations
  /// are shown on the Maps Static API.
  final List<GeocodedLocation>? visible;

  /// Defines the center of the map, equidistant from all edges of the map.
  final GeocodedLocation? center;

  /// Defines the zoom level of the map, which determines the magnification
  /// level of the map. This parameter takes a numerical value corresponding
  /// to the zoom level of the region desired.
  final int? zoom;

  /// This parameter is affected by the scale parameter, the final output
  /// width is the product of the width and scale values
  ///
  /// Static Maps images can be returned in any size up to 640 x 640 pixels.
  /// Google Maps Platform Premium Plan customers, who are correctly
  /// authenticating requests to the Maps Static API, can request images
  /// up to 2048 x 2048 pixels.
  final double? width;

  /// This parameter is affected by the scale parameter, the final output
  /// height is the product of the height and scale values
  ///
  /// Static Maps images can be returned in any size up to 640 x 640 pixels.
  /// Google Maps Platform Premium Plan customers, who are correctly
  /// authenticating requests to the Maps Static API, can request images
  /// up to 2048 x 2048 pixels.
  final double? height;

  /// Affects the number of pixels that are returned. scale=2 returns twice as
  /// many pixels as scale=1 while retaining the same coverage area and level
  /// of detail (i.e. the contents of the map don't change). This is useful
  /// when developing for high-resolution displays, or when generating a map
  /// for printing. The default value is 1. Accepted values are 2 and 4.
  final MapScale? scale;

  /// Defines the format of the resulting image. By default, the Maps Static
  /// API creates PNG images. There are several possible formats including
  /// GIF, JPEG and PNG types. Which format you use depends on how you intend
  /// to present the image. JPEG typically provides greater compression, while
  /// GIF and PNG provide greater detail.
  final MapImageFormat? format;

  /// Defines the type of map to construct. There are several possible maptype
  /// values, including roadmap, satellite, hybrid, and terrain.
  final StaticMapType? maptype;

  /// Defines the language to use for display of labels on map tiles.
  /// Note that this parameter is only supported for some country tiles;
  /// if the specific language requested is not supported for the tile set,
  /// then the default language for that tileset will be used.
  final String? language;

  /// Defines the appropriate borders to display, based on geo-political
  /// sensitivities. Accepts a region code specified as a two-character
  /// ccTLD ('top-level domain') value
  final String? region;

  /// Allows you to monitor your application's API usage in the Google Cloud
  /// Platform Console, and ensures that Google can contact you about your
  /// application if necessary
  final String googleApiKey;

  /// Signature is used to verify that any site generating requests
  /// using your API key is authorized to do so. Requests without a digital
  /// signature might fail
  final String? signature;

  final bool scaleToDevicePixelRatio;

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    final MapScale? scale = scaleToDevicePixelRatio
        ? getScaleForDevicePixelRatio(devicePixelRatio)
        : this.scale;

    
    return SizedBox(
      height: height,
      width: width,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double width = constraints.maxWidth;
          final double height = constraints.maxHeight;

          final StaticMapController mapController = StaticMapController(
            scale: scale,
            width: width.ceil(),
            height: height.ceil(),
            googleApiKey: googleApiKey,
            center: center,
            format: format,
            language: language,
            maptype: maptype,
            markers: markers,
            visible: visible,
            paths: paths,
            region: region,
            signature: signature,
            zoom: zoom,
            styles: styles,
            mapId: mapId,
          );

          return Image.network(
            mapController.url.toString(),
            width: width,
            height: height,
            fit: BoxFit.contain,
          );
        },
      ),
    );
  }
}
