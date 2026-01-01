// ignore_for_file: deprecated_member_use


import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeUtil {
  static ThemeMode currentTheme = ThemeMode.dark;

  static RxBool isDarkMode = false.obs;

  static void changeTheme({required ThemeMode theme}) {
  
    isDarkMode(theme == ThemeMode.light);
    Get.changeThemeMode(theme);
    currentTheme = theme;
  }

  static Future<void> initialize() async {
  ThemeMode.dark;
  
  }
}
