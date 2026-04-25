import 'package:flutter/material.dart';

enum ScreenType { phone, tablet, desktop }

class ResponsiveHelper {
  // Get screen width
  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // Get screen height
  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static ScreenType getScreenType(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width >= 1024) {
      return ScreenType.desktop;
    } else if (width >= 600) {
      return ScreenType.tablet;
    } else {
      return ScreenType.phone;
    }
  }

  // Check if device is phone
  static bool isPhone(BuildContext context) =>
      getScreenType(context) == ScreenType.phone;

  // Check if device is tablet
  static bool isTablet(BuildContext context) =>
      getScreenType(context) == ScreenType.tablet;

  // Check if device is desktop
  static bool isDesktop(BuildContext context) =>
      getScreenType(context) == ScreenType.desktop;
}
