import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors
  static const Color primary = Colors.deepPurple;
  static const Color primaryAccent = Colors.deepPurpleAccent;
  static const Color secondary = Colors.indigo;
  static const Color accent = Colors.cyanAccent;
  static const Color accentDark = Colors.cyan;

  // Dark Theme Palette (Premium Dark/Glassmorphic)
  static const Color darkBgStart = Color(0xFF0C091F);
  static const Color darkBgEnd = Color(0xFF161138);
  static const Color darkCard = Color(0xFF1E1743);
  static const Color darkText = Color(0xFFE5E1FA);
  static const Color darkTextSecondary = Color(0xFFA199C7);
  static const Color darkBorder = Color(0xFF2E245E);

  // Light Theme Palette (Premium Light)
  static const Color lightBgStart = Color(0xFFF5F3FF);
  static const Color lightBgEnd = Color(0xFFE0E7FF);
  static const Color lightCard = Colors.white;
  static const Color lightText = Color(0xFF1A1530);
  static const Color lightTextSecondary = Color(0xFF6B6687);
  static const Color lightBorder = Color(0xFFE4E1F4);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);

  // Gradient definitions
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Colors.cyan, Colors.tealAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkBgGradient = LinearGradient(
    colors: [darkBgStart, darkBgEnd],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient lightBgGradient = LinearGradient(
    colors: [lightBgStart, lightBgEnd],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
