import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: const ColorScheme.dark(
        // Main colors
        primary: Color(0xFFC4E860), // Your primary color
        secondary: Color(0xFF2D2D35), // Your third color
        surface: Color(0xFF14151A), // Your secondary color
        background: Color(0xFF14151A), // Your scaffold background

        // Text colors
        onPrimary: Color(0xFF323232), // Text on primary (textDark)
        onSecondary: Color(0xFFF4F4F4), // Text on secondary (textLight)
        onSurface: Color(0xFFF4F4F4), // Text on surface (textLight)
        onBackground: Color(0xFFF4F4F4), // Text on background (textLight)

        outline: Color(0xFF969696), // Your textMedium
        outlineVariant: Color(0xFF646464), // Your textMediumDark
        tertiary: Color(0xFFD8D8D8), // textLightMedium - Medium-light gray

        // Error colors (you can customize these too)
        error: Color(0xFFD32F2F),
        onError: Color(0xFF000000),
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xFFD1F96B), // Use your primary color for the indicator
        circularTrackColor:
            Color(0xFF2D2D35), // Use your secondary color for the track
      ),

      // Now you can remove scaffoldBackgroundColor because it's in colorScheme
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent, // Will use colorScheme.surface
      ),

      textTheme: const TextTheme(
        displayLarge: AppTypography.displayLarge,
        displayMedium: AppTypography.displayMedium,
        displaySmall: AppTypography.displaySmall,
        headlineLarge: AppTypography.headlineLarge,
        headlineMedium: AppTypography.headlineMedium,
        headlineSmall: AppTypography.headlineSmall,
        titleLarge: AppTypography.titleLarge,
        titleMedium: AppTypography.titleMedium,
        titleSmall: AppTypography.titleSmall,
        labelLarge: AppTypography.labelLarge,
        labelMedium: AppTypography.labelMedium,
        labelSmall: AppTypography.labelSmall,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        bodySmall: AppTypography.bodySmall,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        // Main colors
        primary: Color(0xFFC4E860), // Darker version of your primary color
        secondary: Color(0xFFF5F5F5), // Light grey for secondary
        surface: Color(0xFFFFFFFF), // White surface
        background: Color(0xFFF8F8F8), // Light grey background

        // Text colors
        onPrimary: Color(0xFFFFFFFF), // White text on primary
        onSecondary: Color(0xFF323232), // Dark text on secondary
        onSurface: Color(0xFF323232), // Dark text on surface
        onBackground: Color(0xFF323232), // Dark text on background

        // Additional colors
        tertiary: Color(0xFFE8A8A8), // Lighter version of your tertiary
        outline: Color(0xFF969696), // Your textMedium
        outlineVariant: Color(0xFFB0B0B0), // Lighter outline variant

        // Error colors
        error: Color(0xFFD32F2F),
        onError: Color(0xFFFFFFFF),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Color(0xFF323232), // Dark text for light theme
      ),
      textTheme: const TextTheme(
        displayLarge: AppTypography.displayLarge,
        displayMedium: AppTypography.displayMedium,
        displaySmall: AppTypography.displaySmall,
        headlineLarge: AppTypography.headlineLarge,
        headlineMedium: AppTypography.headlineMedium,
        headlineSmall: AppTypography.headlineSmall,
        titleLarge: AppTypography.titleLarge,
        titleMedium: AppTypography.titleMedium,
        titleSmall: AppTypography.titleSmall,
        labelLarge: AppTypography.labelLarge,
        labelMedium: AppTypography.labelMedium,
        labelSmall: AppTypography.labelSmall,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        bodySmall: AppTypography.bodySmall,
      ),
    );
  }
}
