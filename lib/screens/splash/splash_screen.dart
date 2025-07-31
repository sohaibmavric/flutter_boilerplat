import 'package:flutter/material.dart';
import '../../app/l10n/generated/app_localizations.dart';
import '../../core/constants/spacing.dart';
import '../../app/navigation/main_navigation.dart';

/// Splash screen displayed on app startup
/// Shows app logo, welcome message, and loading indicator
/// Automatically navigates to main app after initialization
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _progressController;
  
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startSplashSequence();
  }

  void _initializeAnimations() {
    // Fade animation for content
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    // Scale animation for logo
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    // Progress animation
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));
  }

  void _startSplashSequence() async {
    // Start animations in sequence
    _fadeController.forward();
    
    await Future.delayed(const Duration(milliseconds: 300));
    _scaleController.forward();
    
    await Future.delayed(const Duration(milliseconds: 500));
    _progressController.forward();

    // Wait for animations to complete and then navigate
    await Future.delayed(const Duration(milliseconds: 2500));
    
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder<void>(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MainNavigation(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topCenter,
            end: AlignmentDirectional.bottomCenter,
            colors: [
              theme.colorScheme.primary.withValues(alpha: 0.1),
              theme.colorScheme.surface,
              theme.colorScheme.primaryContainer.withValues(alpha: 0.05),
            ],
          ),
        ),
        child: SafeArea(
          child: AnimatedBuilder(
            animation: Listenable.merge([
              _fadeAnimation,
              _scaleAnimation,
              _progressAnimation,
            ]),
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsetsDirectional.all(AppSpacing.spaceXL),
                  child: Column(
                    children: [
                      // Top spacer
                      const Spacer(flex: 3),
                      
                      // Logo section
                      _buildLogoSection(context, l10n, theme),
                      
                      const SizedBox(height: AppSpacing.spaceXXL),
                      
                      // Welcome text section
                      _buildWelcomeSection(context, l10n, theme),
                      
                      // Middle spacer
                      // const Spacer(flex: 2),
                      
                      // Loading section
                      _buildLoadingSection(context, l10n, theme),
                      
                      const SizedBox(height: AppSpacing.spaceXL),
                      
                      // Bottom spacer
                      const Spacer(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Logo section with brand icon and animation
  Widget _buildLogoSection(BuildContext context, AppLocalizations l10n, ThemeData theme) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
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
      ),
    );
  }

  /// Welcome message section
  Widget _buildWelcomeSection(BuildContext context, AppLocalizations l10n, ThemeData theme) {
    return Column(
      children: [
        Text(
          l10n.splashWelcome,
          style: theme.textTheme.headlineLarge?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.spaceM),
        Text(
          l10n.splashTagline,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// Loading indicator section
  Widget _buildLoadingSection(BuildContext context, AppLocalizations l10n, ThemeData theme) {
    return Column(
      children: [
        Text(
          l10n.splashLoading,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.spaceL),
        
        // Custom progress indicator
        Container(
          width: 200,
          height: 4,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: _progressAnimation.value,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(
                theme.colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Powered by attribution section
  Widget _buildPoweredBySection(BuildContext context, AppLocalizations l10n, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.flutter_dash,
          size: 16,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: AppSpacing.spaceS),
        Text(
          l10n.poweredBy,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}