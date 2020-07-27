class ResponsiveWidget {
  static bool isScreenLarge(double width, double pixel) {
    return width * pixel >= 720;
  }

  static bool isScreenMedium(double width, double pixel) {
    return width * pixel < 720 && width * pixel >= 480;
  }

  static bool isScreenSmall(double width, double pixel) {
    return width * pixel <= 480;
  }
}
