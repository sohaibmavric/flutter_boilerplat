import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Application theme configuration
/// Provides light and dark theme with proper color schemes and typography
class AppTheme {
  AppTheme._();

  // Light Theme Color Scheme
  static const ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.brand600,
    onPrimary: AppColors.white,
    primaryContainer: AppColors.brand100,
    onPrimaryContainer: AppColors.brand900,
    secondary: AppColors.brand500,
    onSecondary: AppColors.white,
    secondaryContainer: AppColors.brand200,
    onSecondaryContainer: AppColors.brand800,
    tertiary: AppColors.brand400,
    onTertiary: AppColors.brand900,
    tertiaryContainer: AppColors.brand50,
    onTertiaryContainer: AppColors.brand950,
    error: AppColors.error600,
    onError: AppColors.white,
    errorContainer: AppColors.error100,
    onErrorContainer: AppColors.error900,
    surface: AppColors.white,
    onSurface: AppColors.black,
    surfaceContainerHighest: AppColors.brand25,
    onSurfaceVariant: AppColors.brand700,
    outline: AppColors.brand300,
    outlineVariant: AppColors.brand200,
    shadow: AppColors.black,
    scrim: AppColors.black,
    inverseSurface: AppColors.brand900,
    onInverseSurface: AppColors.brand50,
    inversePrimary: AppColors.brand400,
    surfaceTint: AppColors.brand600,
  );

  // Dark Theme Color Scheme
  static const ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.brand400,
    onPrimary: AppColors.brand900,
    primaryContainer: AppColors.brand700,
    onPrimaryContainer: AppColors.brand100,
    secondary: AppColors.brand500,
    onSecondary: AppColors.brand800,
    secondaryContainer: AppColors.brand600,
    onSecondaryContainer: AppColors.brand200,
    tertiary: AppColors.brand300,
    onTertiary: AppColors.brand800,
    tertiaryContainer: AppColors.brand700,
    onTertiaryContainer: AppColors.brand100,
    error: AppColors.error400,
    onError: AppColors.error900,
    errorContainer: AppColors.error700,
    onErrorContainer: AppColors.error100,
    surface: AppColors.black,
    onSurface: AppColors.white,
    surfaceContainerHighest: AppColors.brand950,
    onSurfaceVariant: AppColors.brand300,
    outline: AppColors.brand600,
    outlineVariant: AppColors.brand700,
    shadow: AppColors.black,
    scrim: AppColors.black,
    inverseSurface: AppColors.brand100,
    onInverseSurface: AppColors.brand800,
    inversePrimary: AppColors.brand600,
    surfaceTint: AppColors.brand400,
  );

  // Text Theme using Google Fonts Inter
  static TextTheme get _textTheme {
    return GoogleFonts.interTextTheme(
      const TextTheme(
        // Display styles
        displayLarge: TextStyle(
          fontSize: 57.0,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          height: 1.12,
        ),
        displayMedium: TextStyle(
          fontSize: 45.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.0,
          height: 1.16,
        ),
        displaySmall: TextStyle(
          fontSize: 36.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.0,
          height: 1.22,
        ),
        
        // Headline styles
        headlineLarge: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.0,
          height: 1.25,
        ),
        headlineMedium: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.0,
          height: 1.29,
        ),
        headlineSmall: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.0,
          height: 1.33,
        ),
        
        // Title styles
        titleLarge: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.0,
          height: 1.27,
        ),
        titleMedium: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          height: 1.50,
        ),
        titleSmall: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.43,
        ),
        
        // Body styles
        bodyLarge: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
          height: 1.50,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          height: 1.43,
        ),
        bodySmall: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          height: 1.33,
        ),
        
        // Label styles
        labelLarge: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.43,
        ),
        labelMedium: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.33,
        ),
        labelSmall: TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.45,
        ),
      ),
    );
  }

  /// Light theme configuration
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _lightColorScheme,
      textTheme: _textTheme,
      fontFamily: GoogleFonts.inter().fontFamily,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: _lightColorScheme.surface,
        foregroundColor: _lightColorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
        titleTextStyle: _textTheme.titleLarge?.copyWith(
          color: _lightColorScheme.onSurface,
        ),
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        color: _lightColorScheme.surface,
        surfaceTintColor: _lightColorScheme.surfaceTint,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4), // Little border radius
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
      
      // Filled Button Theme (Material 3 primary button)
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4), // Little border radius
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          minimumSize: const Size(double.infinity, 48), // Full width by default
        ),
      ),
      
      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4), // Little border radius
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          minimumSize: const Size(double.infinity, 48), // Full width by default
          side: BorderSide(color: _lightColorScheme.outline),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _lightColorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _lightColorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _lightColorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _lightColorScheme.error),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  /// Dark theme configuration
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _darkColorScheme,
      textTheme: _textTheme,
      fontFamily: GoogleFonts.inter().fontFamily,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: _darkColorScheme.surface,
        foregroundColor: _darkColorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
        titleTextStyle: _textTheme.titleLarge?.copyWith(
          color: _darkColorScheme.onSurface,
        ),
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        color: _darkColorScheme.surface,
        surfaceTintColor: _darkColorScheme.surfaceTint,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4), // Little border radius
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
      
      // Filled Button Theme (Material 3 primary button)
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4), // Little border radius
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          minimumSize: const Size(double.infinity, 48), // Full width by default
        ),
      ),
      
      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4), // Little border radius
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          minimumSize: const Size(double.infinity, 48), // Full width by default
          side: BorderSide(color: _darkColorScheme.outline),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _darkColorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _darkColorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _darkColorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _darkColorScheme.error),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}