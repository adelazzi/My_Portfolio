import 'package:flutter/material.dart';

class AppColors {
  // Vivid blue-based gradient colors
  static const Color primaryColor = Color(0xFF0000FF); // Blue
  static const Color accentColor = Color(0xFFFF0000); // Dodger Blue
  static const Color tertiaryColor = Color(0xFF4169E1); // Royal Blue
  static const Color quaternaryColor = Color(0xFF4682B4); // Steel Blue

  // Background and card colors
  static const Color backgroundColor =
      Color(0xFFF0F8FF); // Alice Blue background
  static const Color cardColor = Color(0xFFE6E6FA); // Lavender card
  static const Color altCardColor =
      Color(0xFFDCDCDC); // Gainsboro alternative card color

  // Text colors
  static const Color textPrimaryColor = Color(0xFF000000); // Black text
  static const Color textSecondaryColor =
      Color(0xFF696969); // Dim Gray text
  static const Color dividerColor = Color(0xFF4169E1); // Royal Blue divider

  // Creative accent colors
  static const Color successColor =
      Color(0xFF32CD32); // Lime Green for success
  static const Color errorColor = Color(0xFFFF0000); // Red for error
  static const Color warningColor = Color(0xFFFFA500); // Orange for warning

  // Gradient maps for creative elements
  static const List<Color> primaryGradient = [primaryColor, Color(0xFF1E90FF)];
  static const List<Color> accentGradient = [accentColor, Color(0xFF87CEEB)];
  static const List<Color> creativeGradient = [
    Color(0xFF0000FF),
    Color(0xFF1E90FF)
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
  static const String shortBio =
      "Flutter Developer | Full-Stack Engineer | Mobile Development Mentor";
  static const String tagline =
      "Building Performant Mobile Experiences with Flutter";
  static const String email = "azziadel3939@gmail.com";
  static const String phone = "+213 7 93 63 69 45";
  static const String location = "Bab ezzouar, Algeria";
  static const String aboutMe =
      "With over 5 years of experience in Flutter development, I've built and launched more than 5 production-ready "
      "mobile applications, delivering high-quality solutions focused on performance and user experience. My journey includes "
      "a 1-year internship with software companies, where I gained solid industry experience and sharpened my technical and teamwork skills.\n\n"
      "In addition to development, I actively mentor students on their final-year (PFE) projects using Flutter, providing "
      "technical guidance and best practices. As a full-stack developer, I combine Flutter for frontend with Django for backend "
      "to deliver complete, scalable applications.\n\n"
      "Currently pursuing a Master's in High-Performance Computing (HPC), focusing on big data and parallel computing—aiming to "
      "blend intelligent data processing with real-world application development.";

  // Professional Identity
  static const List<String> roles = [
    "Flutter Developer",
    "Full-Stack Engineer",
    "Mobile Development Mentor",
    "M1 HPC Student",
    "Django Backend Developer"
  ];

  static const List<String> personalTraits = [
    "Performance Focused",
    "User Experience Driven",
    "Technical Mentor",
    "Problem Solver",
    "Continuous Learner"
  ];

  // Social Media Links
  static const String github = "https://github.com/adelazzi";
  static const String linkedin =
      "https://www.linkedin.com/in/adel-azzi-99649933b/";

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
  static const String cvUrl =
      'https://drive.google.com/file/d/1ImSAv6fPomGdIckRKtOFBiHjH_PZghLH/view?usp=sharing';
  // Creative quotes for sections
  static const String aboutQuote =
      "< Crafting digital experiences with passion && precision />";
  static const String skillsQuote =
      "const expertise = new Map() .withPerformance() .andCreativity();";
  static const String projectsQuote =
      "function renderInnovation() { return myJourney.map((challenge) => solution); }";
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

  // Animated Background Constants
  static const int particleDensity = 20; // Number of particles per screen
  static const double minParticleSize = 15.0;
  static const double maxParticleSize = 50.0;
  static const double minParticleSpeed = 0.5;
  static const double maxParticleSpeed = 2.0;

  // Icon animation types
  static const List<String> techIconsForBackground = [
    'flutter',
    'dart',
    'hadoop',
    'hive',
    'pig',
    'django',
    'python',
    'firebase',
    'sql',
    'mongodb',
    'figma'
  ];

  // Animation patterns
  static const List<AnimationPattern> animationPatterns = [
    AnimationPattern.float,
    AnimationPattern.pulse,
    AnimationPattern.rotate,
    AnimationPattern.orbit
  ];
}

// Animation patterns for background elements
enum AnimationPattern {
  float, // Gentle up and down movement
  pulse, // Scale in and out
  rotate, // Rotate in place
  orbit // Move in circular path
}
