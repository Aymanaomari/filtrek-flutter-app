import 'package:flutter/material.dart';

class AppTypography {
  // Display styles (largest)
  static const TextStyle displayLarge = TextStyle(
    fontFamily: 'Anton',
    fontSize: 48,
    height: 52 / 48, // 52px line height divided by 48px font size
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: 'Anton',
    fontSize: 45,
    height: 52 / 45, // Maintaining proportional line height
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: 'Anton',
    fontSize: 36,
    height: 42 / 36, // 42px line height
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  // Headline styles (H1, H2, H3) - Using FjallaOne
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: 'FjallaOne',
    fontSize: 32,
    height: 36 / 32, // 36px line height
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: 'FjallaOne',
    fontSize: 24,
    height: 30 / 24, // 30px line height
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: 'FjallaOne',
    fontSize: 20,
    height: 26 / 20, // 26px line height
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  // Title styles (H4, H5, H6) - Using Inter
  static const TextStyle titleLarge = TextStyle(
    fontFamily: 'Inter',
    fontSize: 18,
    height: 24 / 18, // 24px line height
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    height: 24 / 16, // 24px line height
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    height: 20 / 14, // 20px line height
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  // Body text styles - Using Inter
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    height: 24 / 16, // 24px line height
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    height: 20 / 14, // 20px line height
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: 'Inter',
    fontSize: 12,
    height: 16 / 12, // 16px line height
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );

  // Label styles - Using Inter
  static const TextStyle labelLarge = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    height: 20 / 14, // 20px line height
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: 'Inter',
    fontSize: 12,
    height: 16 / 12, // 16px line height
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: 'Inter',
    fontSize: 11,
    height: 16 / 11, // 16px line height
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  // Button and utility styles
  static const TextStyle buttonText = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    height: 20 / 14, // 20px line height
    fontWeight: FontWeight.bold,
    letterSpacing: 0.1,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: 'Inter',
    fontSize: 12,
    height: 16 / 12, // 16px line height
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );

  static const TextStyle overline = TextStyle(
    fontFamily: 'Inter',
    fontSize: 10,
    height: 16 / 10, // 16px line height
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
  );

  // Custom aliases for easier use (like H1, H2, etc.)
  static const TextStyle h1 = headlineLarge; // 32/36
  static const TextStyle h2 = headlineMedium; // 24/30
  static const TextStyle h3 = headlineSmall; // 20/26
  static const TextStyle h4 = titleLarge; // 18/24
  static const TextStyle h5 = titleMedium; // 16/24
  static const TextStyle h6 = titleSmall; // 14/20

  static const TextStyle subtitle1 = titleLarge; // 18/24
  static const TextStyle subtitle2 = titleMedium; // 16/24
  static const TextStyle body1 = bodyLarge; // 16/24
  static const TextStyle body2 = bodyMedium; // 14/20
  static const TextStyle button = buttonText; // 14/20
}
