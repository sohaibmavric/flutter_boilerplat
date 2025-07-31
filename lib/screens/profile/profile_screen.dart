import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/l10n/generated/app_localizations.dart';
import '../../core/services/app_settings_service.dart';
import '../../core/services/onboarding_service.dart';
import '../../core/constants/spacing.dart';
import '../onboarding/onboarding_screen.dart';

/// Settings screen for app configuration
/// Allows users to change theme and language preferences
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  /// Handle logout functionality
  Future<void> _handleLogout(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.logout),
        content: Text('Are you sure you want to logout? This will take you back to the onboarding screen.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: Text(l10n.logout),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      // Reset onboarding status
      await OnboardingService.resetOnboarding();
      
      // Navigate to onboarding screen and clear navigation stack
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<void>(
            builder: (context) => const OnboardingScreen(),
          ),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profile),
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.all(AppSpacing.spaceL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Theme settings section
            Card(
              child: Padding(
                padding: const EdgeInsetsDirectional.all(AppSpacing.spaceL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.themeSettings,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spaceL),
                    _buildThemeSelector(context),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: AppSpacing.spaceL),
            
            // Language settings section
            Card(
              child: Padding(
                padding: const EdgeInsetsDirectional.all(AppSpacing.spaceL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.languageSettings,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spaceL),
                    _buildLanguageSelector(context),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: AppSpacing.spaceXL),
            
            // Additional settings section
            Card(
              child: Padding(
                padding: const EdgeInsetsDirectional.all(AppSpacing.spaceL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.appInformation,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spaceL),
                    ListTile(
                      leading: const Icon(Icons.info_outline),
                      title: Text(l10n.version),
                      subtitle: Text(l10n.versionNumber),
                      contentPadding: EdgeInsetsDirectional.zero,
                    ),
                    ListTile(
                      leading: const Icon(Icons.developer_mode),
                      title: Text(l10n.build),
                      subtitle: Text(l10n.development),
                      contentPadding: EdgeInsetsDirectional.zero,
                    ),
                    const SizedBox(height: AppSpacing.spaceL),
                    Column(
                      children: [
                        FilledButton(
                          onPressed: () => _handleLogout(context),
                          style: FilledButton.styleFrom(
                            backgroundColor: theme.colorScheme.error,
                            foregroundColor: theme.colorScheme.onError,
                          ),
                          child: Text(l10n.logout),
                        ),
                        const SizedBox(height: AppSpacing.spaceM),
                        OutlinedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(l10n.cancel)),
                            );
                          },
                          child: Text(l10n.cancel),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildThemeSelector(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    return Consumer<AppSettingsService>(
      builder: (context, settingsService, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.selectTheme,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.spaceM),
            ...ThemeMode.values.map((themeMode) {
              return RadioListTile<ThemeMode>(
                title: Text(_getThemeModeLabel(themeMode, l10n)),
                value: themeMode,
                groupValue: settingsService.themeMode,
                onChanged: (value) {
                  if (value != null) {
                    settingsService.setThemeMode(value);
                  }
                },
                contentPadding: EdgeInsetsDirectional.zero,
                activeColor: theme.colorScheme.primary,
              );
            }),
          ],
        );
      },
    );
  }
  
  Widget _buildLanguageSelector(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    final supportedLocales = [
      const Locale('en'),
      const Locale('ar'),
    ];
    
    return Consumer<AppSettingsService>(
      builder: (context, settingsService, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.selectLanguage,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.spaceM),
            ...supportedLocales.map((locale) {
              return RadioListTile<Locale>(
                title: Text(_getLanguageLabel(locale, l10n)),
                value: locale,
                groupValue: settingsService.locale,
                onChanged: (value) {
                  if (value != null) {
                    settingsService.setLocale(value);
                  }
                },
                contentPadding: EdgeInsetsDirectional.zero,
                activeColor: theme.colorScheme.primary,
              );
            }),
          ],
        );
      },
    );
  }
  
  String _getThemeModeLabel(ThemeMode themeMode, AppLocalizations l10n) {
    switch (themeMode) {
      case ThemeMode.light:
        return l10n.light;
      case ThemeMode.dark:
        return l10n.dark;
      case ThemeMode.system:
        return l10n.system;
    }
  }
  
  String _getLanguageLabel(Locale locale, AppLocalizations l10n) {
    switch (locale.languageCode) {
      case 'en':
        return l10n.english;
      case 'ar':
        return l10n.arabic;
      default:
        return locale.languageCode;
    }
  }
}