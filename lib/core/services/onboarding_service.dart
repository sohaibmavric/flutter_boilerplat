import 'package:shared_preferences/shared_preferences.dart';
import '../models/onboarding_carousel_item.dart';
import '../../app/l10n/generated/app_localizations.dart';

/// Service to manage onboarding completion status and carousel data
/// Tracks whether user has completed the onboarding flow and provides carousel content
class OnboardingService {
  OnboardingService._();
  
  static const String _onboardingCompletedKey = 'onboarding_completed';
  
  /// Check if user has completed onboarding
  static Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingCompletedKey) ?? false;
  }
  
  /// Mark onboarding as completed
  static Future<void> setOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompletedKey, true);
  }
  
  /// Reset onboarding status (for testing/debugging)
  static Future<void> resetOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_onboardingCompletedKey);
  }

  /// Get all carousel items with localized content
  /// Returns list of carousel items for onboarding
  static List<OnboardingCarouselItem> getCarouselItems(AppLocalizations l10n) {
    return [
      OnboardingCarouselItem(
        subtitle: l10n.healthTracking,
        description: l10n.onboardingHealthDescription,
      ),
      OnboardingCarouselItem(
        subtitle: l10n.education,
        description: l10n.onboardingEducationDescription,
      ),
      OnboardingCarouselItem(
        subtitle: l10n.community,
        description: l10n.onboardingCommunityDescription,
      ),
    ];
  }
}