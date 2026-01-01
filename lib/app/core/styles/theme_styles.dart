// ignore_for_file: deprecated_member_use

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import 'package:my_portfolio/app/core/styles/colors.dart';

class ThemeStyles {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: MainColors.primaryBrand,
    scaffoldBackgroundColor: LightColors.backgroundColor,
    shadowColor: LightColors.shadowColor,
    splashColor: MainColors.primaryBrand.withOpacity(0.2),
    highlightColor: MainColors.primaryBrand.withOpacity(0.1),

    // App Bar Theme
    appBarTheme: AppBarTheme(
      elevation: 1,
      shadowColor: LightColors.shadowColor,
      centerTitle: true,
      titleSpacing: 0,
      iconTheme: IconThemeData(
        color: LightColors.textColor,
        size: 24.sp,
      ),
      actionsIconTheme: IconThemeData(
        color: LightColors.textColor,
        size: 24.sp,
      ),
      titleTextStyle: TextStyle(
        color: LightColors.textColor,
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      backgroundColor: LightColors.backgroundColor,
      surfaceTintColor: Colors.transparent,
    ),

    // Color Scheme - More comprehensive
    colorScheme: ColorScheme.light(
      primary: MainColors.primaryBrand,
      secondary: MainColors.secondaryBrand,
      surface: LightColors.surfaceColor,
      background: LightColors.backgroundColor,
      error: LightColors.errorColor,
      onPrimary: MainColors.whiteColor,
      onSecondary: MainColors.blackColor,
      onSurface: LightColors.onSurfaceColor,
      onBackground: LightColors.textColor,
      onError: MainColors.whiteColor,
      brightness: Brightness.light,
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: MainColors.primaryBrand,
        foregroundColor: MainColors.whiteColor,
        elevation: 2,
        shadowColor: LightColors.shadowColor,
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.3,
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        minimumSize: Size(88.w, 48.h),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: MainColors.primaryBrand,
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: MainColors.primaryBrand,
        side: BorderSide(color: MainColors.primaryBrand, width: 1.5),
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      fillColor: LightColors.inputColor,
      filled: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: MainColors.primaryBrand, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: LightColors.errorColor, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: LightColors.errorColor, width: 2),
      ),
      labelStyle: TextStyle(
        color: LightColors.textColor.withOpacity(0.7),
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: TextStyle(
        color: LightColors.textColor.withOpacity(0.5),
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: TextStyle(
        color: LightColors.errorColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        color: LightColors.textColor,
        letterSpacing: -0.8,
      ),
      displayMedium: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
        color: LightColors.textColor,
        letterSpacing: -0.6,
      ),
      displaySmall: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        color: LightColors.textColor,
        letterSpacing: -0.4,
      ),
      headlineMedium: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: LightColors.textColor,
        letterSpacing: -0.3,
      ),
      headlineSmall: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: LightColors.textColor,
        letterSpacing: -0.2,
      ),
      titleLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: LightColors.textColor,
      ),
      titleMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: LightColors.textColor,
      ),
      labelLarge: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: LightColors.textColor.withOpacity(0.8),
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: LightColors.textColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: LightColors.textColor,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: LightColors.textColor.withOpacity(0.7),
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: LightColors.surfaceColor,
      elevation: 2,
      shadowColor: LightColors.shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      margin: EdgeInsets.zero,
    ),

    // Dialog Theme
    dialogTheme: DialogThemeData(
      backgroundColor: LightColors.surfaceColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      titleTextStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: LightColors.textColor,
      ),
      contentTextStyle: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: LightColors.textColor,
      ),
    ),

    // Bottom Sheet Theme
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: LightColors.surfaceColor,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
    ),

    // Extensions
    extensions: <ThemeExtension<dynamic>>[
      ColorsStyles.light(),
    ],
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: DarkColors.primaryColor,
    scaffoldBackgroundColor: DarkColors.backgroundColor,
    shadowColor: DarkColors.shadowColor,
    splashColor: DarkColors.primaryColor.withOpacity(0.2),
    highlightColor: DarkColors.primaryColor.withOpacity(0.1),

    // App Bar Theme
    appBarTheme: AppBarTheme(
      elevation: 0,
      shadowColor: DarkColors.shadowColor,
      centerTitle: true,
      titleSpacing: 0,
      iconTheme: IconThemeData(
        color: DarkColors.textColor,
        size: 24.sp,
      ),
      actionsIconTheme: IconThemeData(
        color: DarkColors.textColor,
        size: 24.sp,
      ),
      titleTextStyle: TextStyle(
        color: DarkColors.textColor,
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      backgroundColor: DarkColors.backgroundColor,
      surfaceTintColor: Colors.transparent,
    ),

    // Color Scheme - More comprehensive
    colorScheme: ColorScheme.dark(
      primary: DarkColors.primaryColor,
      secondary: DarkColors.secondaryColor,
      surface: DarkColors.surfaceColor,
      background: DarkColors.backgroundColor,
      error: DarkColors.errorColor,
      onPrimary: MainColors.blackColor,
      onSecondary: MainColors.blackColor,
      onSurface: DarkColors.onSurfaceColor,
      onBackground: DarkColors.textColor,
      onError: MainColors.whiteColor,
      brightness: Brightness.dark,
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: DarkColors.primaryColor,
        foregroundColor: MainColors.blackColor,
        elevation: 3,
        shadowColor: DarkColors.shadowColor,
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.3,
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        minimumSize: Size(88.w, 48.h),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: DarkColors.primaryColor,
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: DarkColors.primaryColor,
        side: BorderSide(color: DarkColors.primaryColor, width: 1.5),
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      fillColor: DarkColors.inputColor,
      filled: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: DarkColors.primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: DarkColors.errorColor, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: DarkColors.errorColor, width: 2),
      ),
      labelStyle: TextStyle(
        color: DarkColors.textColor.withOpacity(0.7),
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: TextStyle(
        color: DarkColors.textColor.withOpacity(0.5),
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: TextStyle(
        color: DarkColors.errorColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        color: DarkColors.textColor,
        letterSpacing: -0.8,
      ),
      displayMedium: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
        color: DarkColors.textColor,
        letterSpacing: -0.6,
      ),
      displaySmall: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        color: DarkColors.textColor,
        letterSpacing: -0.4,
      ),
      headlineMedium: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: DarkColors.textColor,
        letterSpacing: -0.3,
      ),
      headlineSmall: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: DarkColors.textColor,
        letterSpacing: -0.2,
      ),
      titleLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: DarkColors.textColor,
      ),
      titleMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: DarkColors.textColor,
      ),
      labelLarge: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: DarkColors.textColor.withOpacity(0.8),
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: DarkColors.textColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: DarkColors.textColor,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: DarkColors.textColor.withOpacity(0.7),
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: DarkColors.surfaceColor,
      elevation: 2,
      shadowColor: DarkColors.shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      margin: EdgeInsets.zero,
    ),

    // Dialog Theme
    dialogTheme: DialogThemeData(
      backgroundColor: DarkColors.surfaceColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      titleTextStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: DarkColors.textColor,
      ),
      contentTextStyle: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: DarkColors.textColor,
      ),
    ),

    // Bottom Sheet Theme
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: DarkColors.surfaceColor,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
    ),

    // Extensions
    extensions: <ThemeExtension<dynamic>>[
      ColorsStyles.dark(),
    ],
  );
}
