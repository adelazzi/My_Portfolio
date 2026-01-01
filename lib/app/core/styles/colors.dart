// ignore_for_file: library_prefixes, prefer_const_constructors

import 'package:flutter/material.dart';


class MainColors {
  // Theme-aware colors with safe fallbacks (non-nullable)
  static Color backgroundColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.backgroundColor ?? 
      LightColors.backgroundColor;

  static Color shadowColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.shadowColor ?? 
      LightColors.shadowColor;

  static Color textColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.textColor ?? 
      LightColors.textColor;

  static Color inputColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.inputColor ?? 
      LightColors.inputColor;

  static Color disableColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.disableColor ?? 
      LightColors.disableColor;

  static Color infoColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.infoColor ?? 
      LightColors.infoColor;

  static Color errorColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.errorColor ?? 
      LightColors.errorColor;

  static Color successColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.successColor ?? 
      LightColors.successColor;

  static Color warningColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.warningColor ?? 
      LightColors.warningColor;

  static Color primaryColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.primaryColor ?? 
      LightColors.primaryColor;

  static Color secondaryColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.secondaryColor ?? 
      LightColors.secondaryColor;

  // Core brand colors (your specified palette)
  static const Color primaryBrand = Color(0xFF02522F);     // Deep forest green
  static const Color secondaryBrand = Color(0xFFD3A536);   // Warm gold
  static const Color accentBrand = Color(0xFF976300);      // Rich bronze
  static const Color tertiaryBrand = Color(0xFF07714D);    // Emerald green

  // Neutrals
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Color(0xFF111827);
  static const Color transparentColor = Colors.transparent;
  
  // Semantic colors for halal food app
  static const Color logoutColor = Color(0xFFDC2626);
  static const Color pendingColor = Color(0x00f59e0b);
  static const Color indicatorColor = Color(0xFF10B981);
  static const Color inactiveColor = Color(0xFF9CA3AF);
  static const Color textInputColor = Color(0xFF1F2937);

  // Modern gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF02522F), Color(0xFF07714D), Color(0xFF10B981)],
    stops: [0.0, 0.6, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldenGradient = LinearGradient(
    colors: [Color(0xFFD3A536), Color(0xFF976300), Color(0xFFB45309)],
    stops: [0.0, 0.7, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFF0FDF4), Color(0xFFFEFCE8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class LightColors {
  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color shadowColor = Color(0x1A000000);
  static const Color textColor = Color(0xFF1F2937);
  static const Color inputColor = Color(0xFFF9FAFB);
  static const Color disableColor = Color(0xFFD1D5DB);
  static const Color infoColor = Color(0xFF3B82F6);
  static const Color errorColor = Color(0xFFEF4444);
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color successColor = Color(0xFF10B981);
  
  // Brand colors stay consistent
  static const Color primaryColor = Color(0xFF02522F);
  static const Color secondaryColor = Color(0xFFD3A536);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color onSurfaceColor = Color(0xFF1F2937);
}

class DarkColors {
  static const Color backgroundColor = Color(0xFF0F1419);
  static const Color shadowColor = Color(0x1A000000);
  static const Color textColor = Color(0xFFF9FAFB);
  static const Color inputColor = Color(0xFF1F2937);
  static const Color disableColor = Color(0xFF4B5563);
  static const Color infoColor = Color(0xFF60A5FA);
  static const Color errorColor = Color(0xFFF87171);
  static const Color warningColor = Color(0xFFFBBF24);
  static const Color successColor = Color(0xFF34D399);
  
  // Brighter brand colors for dark mode visibility
  static const Color primaryColor = Color(0xFF34D399);
  static const Color secondaryColor = Color(0xFFFBBF24);
  static const Color surfaceColor = Color(0xFF1F2937);
  static const Color onSurfaceColor = Color(0xFFF9FAFB);
}

@immutable
class ColorsStyles extends ThemeExtension<ColorsStyles> {
  const ColorsStyles({
    required this.backgroundColor,
    required this.shadowColor,
    required this.textColor,
    required this.inputColor,
    required this.disableColor,
    required this.infoColor,
    required this.errorColor,
    required this.warningColor,
    required this.successColor,
    required this.primaryColor,
    required this.secondaryColor,
    required this.surfaceColor,
    required this.onSurfaceColor,
  });

  final Color backgroundColor;
  final Color shadowColor;
  final Color textColor;
  final Color inputColor;
  final Color disableColor;
  final Color infoColor;
  final Color errorColor;
  final Color warningColor;
  final Color successColor;
  final Color primaryColor;
  final Color secondaryColor;
  final Color surfaceColor;
  final Color onSurfaceColor;

  @override
  ColorsStyles copyWith({
    Color? backgroundColor,
    Color? shadowColor,
    Color? textColor,
    Color? inputColor,
    Color? disableColor,
    Color? infoColor,
    Color? errorColor,
    Color? warningColor,
    Color? successColor,
    Color? primaryColor,
    Color? secondaryColor,
    Color? surfaceColor,
    Color? onSurfaceColor,
  }) {
    return ColorsStyles(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      shadowColor: shadowColor ?? this.shadowColor,
      textColor: textColor ?? this.textColor,
      inputColor: inputColor ?? this.inputColor,
      disableColor: disableColor ?? this.disableColor,
      infoColor: infoColor ?? this.infoColor,
      errorColor: errorColor ?? this.errorColor,
      warningColor: warningColor ?? this.warningColor,
      successColor: successColor ?? this.successColor,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      onSurfaceColor: onSurfaceColor ?? this.onSurfaceColor,
    );
  }

  @override
  ColorsStyles lerp(ThemeExtension<ColorsStyles>? other, double t) {
    if (other is! ColorsStyles) return this;
    
    return ColorsStyles(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      inputColor: Color.lerp(inputColor, other.inputColor, t)!,
      disableColor: Color.lerp(disableColor, other.disableColor, t)!,
      infoColor: Color.lerp(infoColor, other.infoColor, t)!,
      errorColor: Color.lerp(errorColor, other.errorColor, t)!,
      warningColor: Color.lerp(warningColor, other.warningColor, t)!,
      successColor: Color.lerp(successColor, other.successColor, t)!,
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
      surfaceColor: Color.lerp(surfaceColor, other.surfaceColor, t)!,
      onSurfaceColor: Color.lerp(onSurfaceColor, other.onSurfaceColor, t)!,
    );
  }

  // Factory methods for easy theme setup
  static ColorsStyles light() => const ColorsStyles(
    backgroundColor: LightColors.backgroundColor,
    shadowColor: LightColors.shadowColor,
    textColor: LightColors.textColor,
    inputColor: LightColors.inputColor,
    disableColor: LightColors.disableColor,
    infoColor: LightColors.infoColor,
    errorColor: LightColors.errorColor,
    warningColor: LightColors.warningColor,
    successColor: LightColors.successColor,
    primaryColor: LightColors.primaryColor,
    secondaryColor: LightColors.secondaryColor,
    surfaceColor: LightColors.surfaceColor,
    onSurfaceColor: LightColors.onSurfaceColor,
  );

  static ColorsStyles dark() => const ColorsStyles(
    backgroundColor: DarkColors.backgroundColor,
    shadowColor: DarkColors.shadowColor,
    textColor: DarkColors.textColor,
    inputColor: DarkColors.inputColor,
    disableColor: DarkColors.disableColor,
    infoColor: DarkColors.infoColor,
    errorColor: DarkColors.errorColor,
    warningColor: DarkColors.warningColor,
    successColor: DarkColors.successColor,
    primaryColor: DarkColors.primaryColor,
    secondaryColor: DarkColors.secondaryColor,
    surfaceColor: DarkColors.surfaceColor,
    onSurfaceColor: DarkColors.onSurfaceColor,
  );
}
