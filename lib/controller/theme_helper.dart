import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeHelper {
  static Color getPrimaryTextColor(BuildContext context) {
    return Get.isDarkMode ? Colors.white : Colors.black;
  }

  static Color getSecondaryTextColor(BuildContext context) {
    return Get.isDarkMode ? Colors.white70 : Colors.black54;
  }

  static Color getContainerColor(BuildContext context) {
    return Get.isDarkMode ? const Color(0xff243642) : Colors.white;
  }

  static Color getBoxShadowColor(BuildContext context) {
    return Get.isDarkMode
        ? Colors.black.withOpacity(0.3)
        : const Color(0xffd3d3d3).withOpacity(0.84);
  }

  static Color getHighlightTextColor() {
    return const Color(0xff243642);
  }

  static Color getButtonColor() {
    return const Color(0xff243642);
  }
}
