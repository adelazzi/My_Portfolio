import 'package:flutter/material.dart';

class PerformanceConfig {
  // Animation durations - reduced for better performance
  static const Duration fastAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 400);
  static const Duration slowAnimation = Duration(milliseconds: 600);

  // Reduced particle counts for better performance
  static const int maxParticles = 6;
  static const int maxBackgroundElements = 4;

  // Image optimization
  static const double imageQuality = 0.8;
  static const int imageCacheSize = 100;

  // Layout constants
  static const double cardElevation = 4.0;
  static const double borderRadius = 12.0;
  static const EdgeInsets defaultPadding = EdgeInsets.all(16.0);

  // Performance-optimized colors (avoid complex gradients)
  static const Color primaryGradientStart = Color(0xFF8B4513);
  static const Color primaryGradientEnd = Color(0xFF6B3410);
  static const Color accentColor = Color(0xFFCD853F);
  static const Color backgroundColor = Color(0xFFFAF7F0);

  // Text styles for consistency and performance
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Color(0xFF8B4513),
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    color: Color(0xFF333333),
    height: 1.6,
  );

  static const TextStyle captionStyle = TextStyle(
    fontSize: 14,
    color: Color(0xFF666666),
  );

  // Responsive breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  // Animation configurations
  static Widget buildFadeInWidget({
    required Widget child,
    Duration duration = normalAnimation,
    int delay = 0,
  }) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: duration,
      child: child,
    );
  }

  // Optimized card builder
  static Widget buildOptimizedCard({
    required Widget child,
    double? elevation,
    BorderRadius? borderRadius,
    EdgeInsets? margin,
  }) {
    return Card(
      elevation: elevation ?? cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ??
            BorderRadius.circular(PerformanceConfig.borderRadius),
      ),
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8.0),
      child: child,
    );
  }

  // Optimized image builder with caching
  static Widget buildOptimizedImage({
    required String assetPath,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
  }) {
    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      cacheWidth: width?.toInt(),
      cacheHeight: height?.toInt(),
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Icon(Icons.error, color: Colors.grey),
        );
      },
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: fastAnimation,
          child: child,
        );
      },
    );
  }
}
