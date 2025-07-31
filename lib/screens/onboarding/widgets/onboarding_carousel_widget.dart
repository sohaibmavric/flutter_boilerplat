import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/l10n/generated/app_localizations.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/providers/onboarding_provider.dart';

/// Onboarding carousel widget using Provider pattern
/// Displays SIKILA logo and auto-advancing text content
class OnboardingCarouselWidget extends StatelessWidget {
  const OnboardingCarouselWidget({
    super.key,
    this.onSignUp,
    this.onLogIn,
  });

  final VoidCallback? onSignUp;
  final VoidCallback? onLogIn;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    
    return Consumer<OnboardingProvider>(
      builder: (context, provider, child) {
        if (!provider.isInitialized || provider.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(AppSpacing.spaceXL),
          child: Column(
            children: [
              // Top spacing
              const SizedBox(height: AppSpacing.spaceXXXL),
              
              // Fixed title
              Text(
                l10n.welcomeToSikila,
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: AppSpacing.spaceXXXL),
              
              // SIKILA Logo
              _buildLogo(theme),
              
              const SizedBox(height: AppSpacing.spaceXXXL),
              
              // Text carousel
              _buildTextCarousel(theme, provider),
              
              const SizedBox(height: AppSpacing.spaceXL),
              
              // Page indicators
              _buildPageIndicators(theme, provider),
              
              const Spacer(),
              
              // Action buttons
              _buildActionButtons(theme, l10n),
              
              const SizedBox(height: AppSpacing.spaceXL),
            ],
          ),
        );
      },
    );
  }

  /// SIKILA logo matching splash screen design
  Widget _buildLogo(ThemeData theme) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(AppSpacing.spaceXL),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(
        Icons.auto_awesome,
        size: 60,
        color: theme.colorScheme.onPrimary,
      ),
    );
  }

  /// Text carousel with auto-advancing content
  Widget _buildTextCarousel(ThemeData theme, OnboardingProvider provider) {
    return SizedBox(
      height: 200, // Fixed height for carousel
      child: PageView.builder(
        onPageChanged: provider.setCurrentIndex,
        itemCount: provider.itemCount,
        itemBuilder: (context, index) {
          final item = provider.carouselItems[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Subtitle
              Text(
                item.subtitle,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: AppSpacing.spaceL),
              
              // Description
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    item.description,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Page indicators (dots)
  Widget _buildPageIndicators(ThemeData theme, OnboardingProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        provider.itemCount,
        (index) => GestureDetector(
          onTap: () => provider.setCurrentIndex(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(
              horizontal: AppSpacing.spaceXS,
            ),
            width: index == provider.currentIndex ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: index == provider.currentIndex
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outline,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }

  /// Action buttons (Sign Up and Log In)
  Widget _buildActionButtons(ThemeData theme, AppLocalizations l10n) {
    return Column(
      children: [
        // Sign Up button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onSignUp,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.spaceL,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.spaceM),
              ),
            ),
            child: Text(
              l10n.signUpForFree,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
        ),
        
        const SizedBox(height: AppSpacing.spaceL),
        
        // Log In link
        TextButton(
          onPressed: onLogIn,
          child: Text(
            l10n.logIn,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}