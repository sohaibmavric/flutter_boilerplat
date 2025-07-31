import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/l10n/generated/app_localizations.dart';
import '../../core/constants/spacing.dart';
import '../../core/providers/onboarding_provider.dart';
import '../../app/navigation/main_navigation.dart';
import 'widgets/onboarding_carousel_widget.dart';

/// Main onboarding screen with carousel
/// Shows SIKILA logo with auto-advancing text content using Provider pattern
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  Future<void> _completeOnboarding(BuildContext context) async {
    final provider = context.read<OnboardingProvider>();
    await provider.completeOnboarding();
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (context) => const MainNavigation(),
        ),
      );
    }
  }

  void _handleSignUp(BuildContext context) {
    // TODO: Navigate to sign up screen
    _completeOnboarding(context);
  }

  void _handleLogIn(BuildContext context) {
    // TODO: Navigate to log in screen
    _completeOnboarding(context);
  }

  void _skipOnboarding(BuildContext context) {
    _completeOnboarding(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    
    return ChangeNotifierProvider(
      create: (_) => OnboardingProvider()..initializeCarousel(l10n),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: theme.colorScheme.surface,
          body: SafeArea(
            child: Column(
              children: [
                // Top bar with skip button
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.spaceL),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Skip button
                      TextButton(
                        onPressed: () => _skipOnboarding(context),
                        child: Text(
                          l10n.skip,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Onboarding carousel using Provider
                Expanded(
                  child: OnboardingCarouselWidget(
                    onSignUp: () => _handleSignUp(context),
                    onLogIn: () => _handleLogIn(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}