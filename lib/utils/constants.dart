import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF3F51B5);     // Indigo
  static const Color accentColor = Color(0xFF00BCD4);      // Cyan
  static const Color backgroundColor = Color(0xFFF5F5F5);  // Off-white
  static const Color cardColor = Color(0xFFFFFFFF);        // White
  static const Color textPrimaryColor = Color(0xFF212121); // Dark grey
  static const Color textSecondaryColor = Color(0xFF757575); // Medium grey
  static const Color dividerColor = Color(0xFFDDDDDD);     // Light grey
}

class AppConstants {
  // Portfolio Information
  static const String fullName = "Your Name";
  static const String shortBio = "Full Stack Developer";
  static const String email = "your.email@example.com";
  static const String phone = "+1 123 456 7890";
  static const String location = "Your City, Country";
  static const String aboutMe =
      "I am a passionate Full Stack Developer with expertise in both frontend and backend technologies. "
      "With a strong foundation in computer science and a keen eye for design, I create seamless, "
      "responsive applications that deliver exceptional user experiences.";

  // Social Media Links
  static const String github = "https://github.com/yourusername";
  static const String linkedin = "https://linkedin.com/in/yourusername";
  static const String twitter = "https://twitter.com/yourusername";

  // Section Titles
  static const String aboutTitle = "About Me";
  static const String educationTitle = "Education";
  static const String experienceTitle = "Experience";
  static const String skillsTitle = "Skills";
  static const String projectsTitle = "Projects";
  static const String contactTitle = "Contact Me";
}

// Responsive breakpoints
class ScreenSize {
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;
}
