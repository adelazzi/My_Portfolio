import 'package:flutter/material.dart';

class AppColors {
  // Brown-based gradient colors
  static const Color primaryColor = Color(0xFF8B4513); // Saddle Brown
  static const Color accentColor = Color(0xFFD2691E); // Chocolate
  static const Color tertiaryColor = Color(0xFFDEB887); // Burlywood
  static const Color quaternaryColor = Color(0xFFA0522D); // Sienna

  // Background and card colors
  static const Color backgroundColor = Color(0xFF2E1E12); // Dark brown background
  static const Color cardColor = Color(0xFF3A291F); // Darker brown card
  static const Color altCardColor = Color(0xFF4E3629); // Alternative brown card color

  // Text colors
  static const Color textPrimaryColor = Color(0xFFECECEC); // Light text
  static const Color textSecondaryColor =
      Color(0xFFD9CBC4); // Medium light text with brown tint
  static const Color dividerColor = Color(0xFF5A4636); // Subtle brown divider

  // Creative accent colors
  static const Color successColor = Color(0xFF6B8E23); // Olive green for success
  static const Color errorColor = Color(0xFFB22222); // Firebrick red for error
  static const Color warningColor = Color(0xFFDAA520); // Goldenrod for warning

  // Gradient maps for creative elements
  static const List<Color> primaryGradient = [primaryColor, Color(0xFF654321)];
  static const List<Color> accentGradient = [accentColor, Color(0xFFA86E3D)];
  static const List<Color> creativeGradient = [
    Color(0xFF8B4513),
    Color(0xFFCD853F)
  ];

  // Shadows for depth
  static final List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 15,
      offset: const Offset(0, 5),
    ),
  ];
}

class AppConstants {
  // Portfolio Information
  static const String fullName = "ADEL AZZI";
  static const String shortBio = "Full Stack Developer | Mobile App Developer";
  static const String tagline = "Crafting Digital Experiences That Inspire";
  static const String email = "azziadel3939@gmail.com";
  static const String phone = "+213 7 93 63 69 45";
  static const String location = "Bab ezzouar, Algeria";
  static const String aboutMe =
      "I transform ideas into elegant digital realities. As a passionate Full Stack Developer with "
      "a creative mindset, I blend artistic vision with technical expertise to build intuitive, "
      "responsive applications that not only work flawlessly but also tell compelling stories. "
      "My journey in technology is driven by a relentless curiosity and a desire to push the boundaries "
      "of what's possible in the digital realm.";

  // Professional Identity
  static const List<String> roles = [
    "Full Stack Developer",
    "UI/UX Enthusiast",
    "Mobile App Creator",
    "Problem Solver",
    "Digital Innovator"
  ];

  static const List<String> personalTraits = [
    "Creative Thinker",
    "Detail-Oriented",
    "Continuous Learner",
    "Team Collaborator",
    "User-Focused"
  ];

  // Social Media Links
  static const String github = "https://github.com/yourusername";
  static const String linkedin = "https://linkedin.com/in/yourusername";
  static const String twitter = "https://twitter.com/yourusername";
  static const String dribbble = "https://dribbble.com/yourusername";
  static const String medium = "https://medium.com/@yourusername";

  // Creative Section Titles
  static const String aboutTitle = "< About Me />";
  static const String educationTitle = "{ Education }";
  static const String experienceTitle = "Experience.map()";
  static const String skillsTitle = "Skills.expertise";
  static const String projectsTitle = "Featured Projects";
  static const String contactTitle = "Let's Connect!";

  // Creative Call-to-Actions
  static const String hireMeCTA = "Start a Project Together";
  static const String viewWorkCTA = "Explore My Creations";
  static const String downloadCVCTA = "Download My CV";

  // Creative quotes for sections
  static const String aboutQuote =
      "Code is poetry in motion, and I'm the poet.";
  static const String skillsQuote =
      "My toolbox is diverse, my approach is methodical.";
  static const String projectsQuote =
      "Every line of code tells a story. Here are my best chapters.";
}

// Responsive breakpoints
class ScreenSize {
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;
}

// Creative Animation Constants
class AnimationConstants {
  // Duration constants
  static const Duration fast = Duration(milliseconds: 400);
  static const Duration medium = Duration(milliseconds: 800);
  static const Duration slow = Duration(milliseconds: 1200);

  // Offset constants for slide animations
  static const double smallOffset = 0.2;
  static const double mediumOffset = 0.4;
  static const double largeOffset = 0.6;

  // Stagger delay
  static const Duration staggerDelay = Duration(milliseconds: 100);

  // Curves
  static const Curve defaultCurve = Curves.easeOutCubic;
  static const Curve bounceCurve = Curves.elasticOut;
  static const Curve sharpCurve = Curves.easeInOutQuint;

  // Page transitions
  static const Duration pageTransitionDuration = Duration(milliseconds: 600);

  // Hover effects
  static const double hoverScale = 1.05;
  static const Duration hoverDuration = Duration(milliseconds: 200);
}

// Creative Design Elements
class DesignElements {
  // Border radiuses
  static const double smallRadius = 8.0;
  static const double mediumRadius = 16.0;
  static const double largeRadius = 24.0;
  static const double circularRadius = 100.0;

  // Spacing
  static const double tinySpace = 4.0;
  static const double smallSpace = 8.0;
  static const double mediumSpace = 16.0;
  static const double largeSpace = 24.0;
  static const double extraLargeSpace = 36.0;

  // Elevations
  static const double lowElevation = 2.0;
  static const double mediumElevation = 6.0;
  static const double highElevation = 12.0;

  // Typography scales
  static const double displayLargeSize = 56.0;
  static const double displayMediumSize = 48.0;
  static const double displaySmallSize = 36.0;
  static const double headlineSize = 24.0;
  static const double titleSize = 20.0;
  static const double bodySize = 16.0;
  static const double captionSize = 14.0;

  // Creative shapes
  static const List<double> wavyPattern = [0, 20, -20, 40, -40, 20, -20, 0];
  static const List<double> zigzagPattern = [0, 30, 0, -30, 0, 30, 0, -30];
}
