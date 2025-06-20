import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

class AppTheme {
  // Creative modern theme - Light Mode
  static ThemeData get lightTheme => ThemeData(
        primaryColor: AppColors.primaryColor,
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: AppColors.primaryColor,
          secondary: AppColors.accentColor,
          tertiary: AppColors.tertiaryColor,
          background: Colors.white,
          surface: const Color(0xFFFAFAFA),
          outline: AppColors.dividerColor,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        textTheme:
            GoogleFonts.outfitTextTheme(ThemeData.light().textTheme).copyWith(
          // Main display headings - using Outfit for a more modern look
          displayLarge: GoogleFonts.outfit(
            fontSize: DesignElements.displayLargeSize,
            fontWeight: FontWeight.w800,
            color: AppColors.primaryColor,
            letterSpacing: -0.5,
            height: 1.1,
          ),
          displayMedium: GoogleFonts.outfit(
            fontSize: DesignElements.displayMediumSize,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
            letterSpacing: -0.3,
          ),
          displaySmall: GoogleFonts.outfit(
            fontSize: DesignElements.displaySmallSize,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryColor,
            letterSpacing: -0.2,
          ),

          // Section headings
          headlineLarge: GoogleFonts.outfit(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
          headlineMedium: GoogleFonts.outfit(
            fontSize: DesignElements.headlineSize,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),

          // Title and body text
          titleLarge: GoogleFonts.outfit(
            fontSize: DesignElements.titleSize,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            letterSpacing: 0.15,
          ),
          titleMedium: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
            letterSpacing: 0.1,
          ),
          bodyLarge: GoogleFonts.outfit(
            fontSize: DesignElements.bodySize,
            fontWeight: FontWeight.w400,
            color: Colors.black54,
            height: 1.5,
          ),
          bodyMedium: GoogleFonts.outfit(
            fontSize: DesignElements.captionSize,
            color: Colors.black54,
            height: 1.4,
          ),

          // Creative label style for buttons
          labelLarge: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        // Modern app bar with gradient background
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.outfit(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
          iconTheme: const IconThemeData(color: Colors.white, size: 24),
          shadowColor: Colors.black26,
        ),
        // Modern card with subtle elevation and rounded corners
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: DesignElements.mediumElevation,
          shadowColor: Colors.black12,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignElements.mediumRadius),
          ),
        ),
        // Creative button theme
        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.accentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignElements.mediumRadius),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
        // Modern elevated buttons with gradient effect
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.accentColor),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(DesignElements.mediumRadius),
              ),
            ),
            elevation: MaterialStateProperty.all(DesignElements.lowElevation),
            shadowColor: MaterialStateProperty.all(
                AppColors.accentColor.withOpacity(0.4)),
            overlayColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return AppColors.primaryColor.withOpacity(0.2);
              }
              if (states.contains(MaterialState.hovered)) {
                return AppColors.primaryColor.withOpacity(0.1);
              }
              return null;
            }),
          ),
        ),
        // Creative outlined button style
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primaryColor,
            side: BorderSide(color: AppColors.primaryColor, width: 1.5),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(DesignElements.mediumRadius),
            ),
          ),
        ),
        // Modern divider theme
        dividerTheme: const DividerThemeData(
          color: AppColors.dividerColor,
          thickness: 1,
          space: 32,
          indent: 16,
          endIndent: 16,
        ),
        // Modern input decoration
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignElements.mediumRadius),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignElements.mediumRadius),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignElements.mediumRadius),
            borderSide: BorderSide(color: AppColors.accentColor, width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          labelStyle: TextStyle(color: Colors.grey.shade600),
          floatingLabelStyle: TextStyle(color: AppColors.primaryColor),
        ),
      );

  // Creative dark theme with neon accents
  static ThemeData get darkTheme => ThemeData(
        primaryColor: AppColors.accentColor,
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: AppColors.accentColor,
          secondary: AppColors.tertiaryColor,
          tertiary: AppColors.quaternaryColor,
          background: AppColors.backgroundColor,
          surface: AppColors.cardColor,
          onSurface: AppColors.textPrimaryColor,
        ),
        scaffoldBackgroundColor: AppColors.backgroundColor,
        cardColor: AppColors.cardColor,
        canvasColor: AppColors.backgroundColor,
        textTheme:
            GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).copyWith(
          // Creative display headings with gradient effect potential
          displayLarge: GoogleFonts.outfit(
            fontSize: DesignElements.displayLargeSize,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: -0.5,
            height: 1.1,
          ),
          displayMedium: GoogleFonts.outfit(
            fontSize: DesignElements.displayMediumSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: -0.3,
          ),
          displaySmall: GoogleFonts.outfit(
            fontSize: DesignElements.displaySmallSize,
            fontWeight: FontWeight.w700,
            color: AppColors.accentColor,
            letterSpacing: -0.2,
          ),

          // Futuristic section headings
          headlineLarge: GoogleFonts.outfit(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          headlineMedium: GoogleFonts.outfit(
            fontSize: DesignElements.headlineSize,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),

          // Sleek title and body text
          titleLarge: GoogleFonts.outfit(
            fontSize: DesignElements.titleSize,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.15,
          ),
          titleMedium: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.9),
            letterSpacing: 0.1,
          ),
          bodyLarge: GoogleFonts.outfit(
            fontSize: DesignElements.bodySize,
            fontWeight: FontWeight.w400,
            color: Colors.white70,
            height: 1.5,
          ),
          bodyMedium: GoogleFonts.outfit(
            fontSize: DesignElements.captionSize,
            color: Colors.white60,
            height: 1.4,
          ),

          // Creative label style for buttons with glow effect potential
          labelLarge: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: Colors.white,
          ),
        ),
        // Sleek, futuristic app bar
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.cardColor,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.outfit(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
          iconTheme: IconThemeData(color: AppColors.accentColor, size: 24),
        ),
        // Futuristic card with subtle glow
        cardTheme: CardTheme(
          color: AppColors.cardColor,
          elevation: DesignElements.mediumElevation,
          shadowColor: AppColors.accentColor.withOpacity(0.1),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignElements.mediumRadius),
          ),
        ), // Neon-style buttons
        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.accentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignElements.mediumRadius),
          ),
        ),
        // Glowing elevated button style
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.accentColor),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(DesignElements.mediumRadius),
              ),
            ),
            elevation: MaterialStateProperty.all(DesignElements.lowElevation),
            shadowColor: MaterialStateProperty.all(
                AppColors.accentColor.withOpacity(0.6)),
            overlayColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return AppColors.accentColor.withOpacity(0.3);
              }
              if (states.contains(MaterialState.hovered)) {
                return AppColors.accentColor.withOpacity(0.2);
              }
              return null;
            }),
          ),
        ),
        // Futuristic outlined button style
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.accentColor,
            side: BorderSide(color: AppColors.accentColor, width: 1.5),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(DesignElements.mediumRadius),
            ),
          ),
        ),
        // Modern divider with glow effect
        dividerTheme: DividerThemeData(
          color: AppColors.dividerColor,
          thickness: 1,
          space: 32,
          indent: 16,
          endIndent: 16,
        ),
        // Futuristic input style
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.backgroundColor.withOpacity(0.6),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignElements.mediumRadius),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignElements.mediumRadius),
            borderSide: BorderSide(color: AppColors.dividerColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignElements.mediumRadius),
            borderSide: BorderSide(color: AppColors.accentColor, width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          labelStyle: TextStyle(color: Colors.white70),
          floatingLabelStyle: TextStyle(color: AppColors.accentColor),
        ),
      );
}
