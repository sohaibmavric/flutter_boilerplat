import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/onboarding_carousel_item.dart';
import '../services/onboarding_service.dart';
import '../../app/l10n/generated/app_localizations.dart';

/// Provider for managing onboarding state and carousel operations
/// Handles carousel progression, auto-advance, and completion state
class OnboardingProvider extends ChangeNotifier {
  // Private state variables
  List<OnboardingCarouselItem> _carouselItems = [];
  int _currentIndex = 0;
  bool _isAutoAdvancing = true;
  Timer? _autoAdvanceTimer;
  bool _isInitialized = false;

  // Public getters
  /// List of carousel items (immutable)
  List<OnboardingCarouselItem> get carouselItems => List.unmodifiable(_carouselItems);
  
  /// Current carousel index
  int get currentIndex => _currentIndex;
  
  /// Whether auto-advance is enabled
  bool get isAutoAdvancing => _isAutoAdvancing;
  
  /// Whether the provider has been initialized
  bool get isInitialized => _isInitialized;
  
  /// Whether there are carousel items
  bool get hasData => _carouselItems.isNotEmpty;
  
  /// Whether the carousel is empty
  bool get isEmpty => _carouselItems.isEmpty;
  
  /// Number of carousel items
  int get itemCount => _carouselItems.length;

  /// Initializes carousel items with localized content
  void initializeCarousel(AppLocalizations l10n) {
    if (!_isInitialized) {
      _carouselItems = OnboardingService.getCarouselItems(l10n);
      _isInitialized = true;
      _startAutoAdvance();
      notifyListeners();
    }
  }

  /// Sets the current carousel index
  void setCurrentIndex(int index) {
    if (index >= 0 && index < _carouselItems.length && index != _currentIndex) {
      _currentIndex = index;
      _restartAutoAdvance();
      notifyListeners();
    }
  }

  /// Moves to the next carousel item
  void nextPage() {
    if (_carouselItems.isNotEmpty) {
      final nextIndex = (_currentIndex + 1) % _carouselItems.length;
      setCurrentIndex(nextIndex);
    }
  }

  /// Moves to the previous carousel item
  void previousPage() {
    if (_carouselItems.isNotEmpty) {
      final previousIndex = (_currentIndex - 1 + _carouselItems.length) % _carouselItems.length;
      setCurrentIndex(previousIndex);
    }
  }

  /// Toggles auto-advance functionality
  void toggleAutoAdvance() {
    _isAutoAdvancing = !_isAutoAdvancing;
    if (_isAutoAdvancing) {
      _startAutoAdvance();
    } else {
      _stopAutoAdvance();
    }
    notifyListeners();
  }

  /// Marks onboarding as completed
  Future<void> completeOnboarding() async {
    await OnboardingService.setOnboardingCompleted();
  }

  /// Private helper to start auto-advance timer
  void _startAutoAdvance() {
    if (_isAutoAdvancing && _carouselItems.isNotEmpty) {
      _stopAutoAdvance();
      _autoAdvanceTimer = Timer.periodic(
        const Duration(seconds: 4),
        (timer) {
          if (_isAutoAdvancing) {
            nextPage();
          }
        },
      );
    }
  }

  /// Private helper to stop auto-advance timer
  void _stopAutoAdvance() {
    _autoAdvanceTimer?.cancel();
    _autoAdvanceTimer = null;
  }

  /// Private helper to restart auto-advance timer
  void _restartAutoAdvance() {
    if (_isAutoAdvancing) {
      _stopAutoAdvance();
      _startAutoAdvance();
    }
  }

  @override
  void dispose() {
    _stopAutoAdvance();
    _carouselItems.clear();
    super.dispose();
  }
}