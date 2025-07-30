import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'l10n/generated/app_localizations.dart';
import '../core/services/app_settings_service.dart';
import 'navigation/main_navigation.dart';

/// Main application widget
/// Configures theme, localization, routing, and state management
class SikilaApp extends StatelessWidget {
  const SikilaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppSettingsService()..initialize(),
      child: Consumer<AppSettingsService>(
        builder: (context, settingsService, child) {
          return MaterialApp(
            title: 'Sikila',
            debugShowCheckedModeBanner: false,
            
            // Theme configuration with dynamic theme mode
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: settingsService.themeMode,
            
            // Localization configuration with dynamic locale
            locale: settingsService.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'), // English
              Locale('ar'), // Arabic
            ],
            
            // RTL support
            localeResolutionCallback: (locale, supportedLocales) {
              // Check if the current device locale is supported
              for (final supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale?.languageCode) {
                  return supportedLocale;
                }
              }
              // If the locale of the device is not supported, use the first one
              // from the list (English, in this case).
              return supportedLocales.first;
            },
            
            // Main navigation with bottom navigation bar
            home: const MainNavigation(),
          );
        },
      ),
    );
  }
}

