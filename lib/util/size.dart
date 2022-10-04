import 'dart:ui' as ui;

class ScreenSize {
  static final double _width =
      ui.window.physicalSize.width / ui.window.devicePixelRatio;
  static final double _height =
      ui.window.physicalSize.height / ui.window.devicePixelRatio;
  static const double _figmaScreenWidth = 375;
  static const double _figmaScreenHeight = 812;

  // Ratio of device width / figma's width
  static double get getScreenRatioWidthFigma => _width / _figmaScreenWidth;
  static double get getScreenRatioHeightFigma => _height / _figmaScreenHeight;

  static double get width => _width;
  static double get height => _height;
}

extension ScreenSizeDoubleExtensions on double {
  double get h {
    return this * ScreenSize.getScreenRatioHeightFigma;
  }

  double get w {
    return this * ScreenSize.getScreenRatioWidthFigma;
  }
}

extension ScreenSizeIntExtensions on int {
  double get h {
    return this * ScreenSize.getScreenRatioHeightFigma;
  }

  double get w {
    return this * ScreenSize.getScreenRatioWidthFigma;
  }
}
