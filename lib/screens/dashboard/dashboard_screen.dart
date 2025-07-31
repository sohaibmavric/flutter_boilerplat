import 'package:flutter/material.dart';
import '../../app/l10n/generated/app_localizations.dart';
import '../../core/constants/spacing.dart';
import 'dart:math' as math;

/// Health tracking dashboard screen
/// Shows personalized greeting, water logging, and health tracking cards
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double waterConsumed = 210.0; // Current water intake in ml
  double waterGoal = 2200.0; // Daily water goal in ml

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLowest,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.all(AppSpacing.spaceL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with greeting and notification
              _buildHeader(context, l10n, theme),
              
              const SizedBox(height: AppSpacing.spaceXL),
              
              // Water log section
              _buildWaterLogSection(context, l10n, theme),
              
              const SizedBox(height: AppSpacing.spaceXL),
              
              // Health tracking cards
              _buildHealthTrackingCards(context, l10n, theme),
            ],
          ),
        ),
      ),
    );
  }

  /// Header with time-based greeting and notification icon
  Widget _buildHeader(BuildContext context, AppLocalizations l10n, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${_getTimeBasedGreeting(l10n)}, ${l10n.userName}!',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        Container(
          padding: const EdgeInsetsDirectional.all(AppSpacing.spaceS),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppSpacing.spaceM),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            Icons.notifications_outlined,
            color: theme.colorScheme.primary  ,
            size: 24,
          ),
        ),
      ],
    );
  }

  /// Water log section with circular progress and button
  Widget _buildWaterLogSection(BuildContext context, AppLocalizations l10n, ThemeData theme) {
    final double percentage = (waterConsumed / waterGoal).clamp(0.0, 1.0);
    final double remaining = math.max(0, waterGoal - waterConsumed);
    
    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.spaceXL),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSpacing.spaceL),
      ),
      child: Column(
        children: [
          // Section title
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              l10n.waterLog,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          
          const SizedBox(height: AppSpacing.spaceXL),
          
          // Circular progress indicator
          SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background circle
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    value: 1.0,
                    strokeWidth: 12,
                    backgroundColor: theme.colorScheme.surface,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      theme.colorScheme.surface,
                    ),
                  ),
                ),
                // Progress circle
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    value: percentage,
                    strokeWidth: 12,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      theme.colorScheme.primary,
                    ),
                  ),
                ),
                // Center content
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.todaysGoal,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spaceXXS),
                    Text(
                      '${waterGoal.toInt()}${l10n.ml}',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spaceXXS),
                    Text(
                      '${l10n.remaining}: ${remaining.toInt()}${l10n.ml}',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      l10n.atYourGoal,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppSpacing.spaceXL),
          
          // Log Water button
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => _handleLogWater(context, l10n),
              style: FilledButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                padding: const EdgeInsetsDirectional.symmetric(
                  vertical: AppSpacing.spaceL,
                ),
              ),
              child: Text(
                l10n.logWater,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Health tracking cards grid
  Widget _buildHealthTrackingCards(BuildContext context, AppLocalizations l10n, ThemeData theme) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: AppSpacing.spaceL,
      crossAxisSpacing: AppSpacing.spaceL,
      childAspectRatio: 1.0,
      children: [
        _buildHealthCard(
          context: context,
          theme: theme,
          icon: Icons.flash_on,
          title: l10n.logPain,
          onTap: () => _handleHealthAction(context, l10n.logPain),
        ),
        _buildHealthCard(
          context: context,
          theme: theme,
          icon: Icons.water_drop,
          title: l10n.logBlood,
          onTap: () => _handleHealthAction(context, l10n.logBlood),
        ),
        _buildHealthCard(
          context: context,
          theme: theme,
          icon: Icons.medication,
          title: l10n.logMedication,
          onTap: () => _handleHealthAction(context, l10n.logMedication),
        ),
        _buildHealthCard(
          context: context,
          theme: theme,
          icon: Icons.bedtime,
          title: l10n.logSleep,
          onTap: () => _handleHealthAction(context, l10n.logSleep),
        ),
      ],
    );
  }

  /// Individual health tracking card
  Widget _buildHealthCard({
    required BuildContext context,
    required ThemeData theme,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.spaceL),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.spaceL),
        child: Padding(
          padding: const EdgeInsetsDirectional.all(AppSpacing.spaceL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Plus icon in circle
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.outline.withValues(alpha: 0.5),
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.add,
                  color: theme.colorScheme.onSurface,
                  size: 24,
                ),
              ),
              
              const SizedBox(height: AppSpacing.spaceM),
              
              // Title and icon
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.spaceS),
                  Icon(
                    icon,
                    size: 16,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Get time-based greeting
  String _getTimeBasedGreeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    
    if (hour >= 5 && hour < 12) {
      return l10n.goodMorning;
    } else if (hour >= 12 && hour < 17) {
      return l10n.goodAfternoon;
    } else {
      return l10n.goodEvening;
    }
  }

  /// Handle log water action
  void _handleLogWater(BuildContext context, AppLocalizations l10n) {
    setState(() {
      // Add 250ml to water intake (example)
      waterConsumed = math.min(waterConsumed + 250, waterGoal);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${l10n.logWater} - 250${l10n.ml} ${l10n.success.toLowerCase()}'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Handle health tracking actions
  void _handleHealthAction(BuildContext context, String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$action ${AppLocalizations.of(context)!.success.toLowerCase()}'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}