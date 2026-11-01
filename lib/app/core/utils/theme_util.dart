import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeUtil {
  /// Light is the default; visitors can switch from the top bar.
  static final Rx<ThemeMode> mode = ThemeMode.light.obs;

  static ThemeMode get currentTheme => mode.value;

  /// `?theme=dark` in the link opens the dark theme.
  static void initialize({String? requested}) {
    if (requested == 'dark') mode.value = ThemeMode.dark;
  }

  static bool get isDark => mode.value == ThemeMode.dark;

  static void toggle() => changeTheme(theme: isDark ? ThemeMode.light : ThemeMode.dark);

  static void changeTheme({required ThemeMode theme}) {
    mode.value = theme;
    Get.changeThemeMode(theme);
  }
}
