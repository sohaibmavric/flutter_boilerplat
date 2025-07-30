/// App fonts constants following the design system guidelines
/// Centralized font management for consistent typography
class AppFonts {
  AppFonts._();

  /// Primary font family - Google Fonts Inter
  /// Used throughout the app for all text styles
  static const String primary = 'Inter';

  /// Font weights available for Inter
  static const Map<String, int> weights = {
    'regular': 400,
    'medium': 500,
    'semiBold': 600,
    'bold': 700,
  };

  /// Usage examples:
  /// - Text style should use theme.textTheme.* for consistency
  /// - FontFamily is automatically applied via theme configuration
  /// - Individual weight overrides: FontWeight.w400, FontWeight.w500, etc.
}