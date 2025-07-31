import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/services/onboarding_service.dart';
import '../core/services/app_settings_service.dart';
import '../screens/onboarding/onboarding_screen.dart';
import 'navigation/main_navigation.dart';
import 'theme/app_theme.dart';
import 'l10n/generated/app_localizations.dart';

/// Main Sikila application widget
/// Configures theme, localization, and routing
class SikilaApp extends StatefulWidget {
  const SikilaApp({super.key});

  @override
  State<SikilaApp> createState() => _SikilaAppState();
}

class _SikilaAppState extends State<SikilaApp> {
  late AppSettingsService _settingsService;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    _settingsService = AppSettingsService();
    await _settingsService.initialize();
    
    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return ChangeNotifierProvider<AppSettingsService>(
      create: (_) => _settingsService,
      child: Consumer<AppSettingsService>(
        builder: (context, settingsService, child) {
          return MaterialApp(
            title: 'Sikila',
            debugShowCheckedModeBanner: false,
            
            // Theme configuration with settings service
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: settingsService.themeMode,
            
            // Localization configuration with settings service
            locale: settingsService.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            
            // Home widget that handles onboarding flow
            home: const AppHome(),
          );
        },
      ),
    );
  }
}

/// Main app wrapper that handles onboarding flow
/// Shows onboarding screens for new users, main navigation for existing users
class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  bool? _isOnboardingCompleted;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    final isCompleted = await OnboardingService.isOnboardingCompleted();
    if (mounted) {
      setState(() {
        _isOnboardingCompleted = isCompleted;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator while checking onboarding status
    if (_isOnboardingCompleted == null) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Show onboarding for new users, main navigation for existing users
    return _isOnboardingCompleted!
        ? const MainNavigation()
        : const OnboardingScreen();
  }
}