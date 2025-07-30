import 'package:flutter/material.dart';
import '../../app/l10n/generated/app_localizations.dart';
import '../../core/constants/spacing.dart';
// import '../../core/constants/app_icons.dart'; // TODO: Use when custom SVG assets are available
// import '../../core/constants/app_images.dart'; // TODO: Use when custom image assets are available

/// Dashboard screen displaying main app content and overview
/// Contains user statistics, quick actions, and navigation shortcuts
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.dashboard,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: theme.colorScheme.onSurface,
            ),
            onPressed: () {
              // Handle notifications
            },
          ),
          const SizedBox(width: AppSpacing.spaceS),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.all(AppSpacing.spaceL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome section with illustration
            _buildWelcomeSection(context, l10n, theme),
            
            const SizedBox(height: AppSpacing.spaceXL),
            
            // Statistics section
            _buildStatsSection(context, l10n, theme),
            
            const SizedBox(height: AppSpacing.spaceXL),
          ],
        ),
      ),
    );
  }

  /// Welcome section with user greeting and illustration
  Widget _buildWelcomeSection(BuildContext context, AppLocalizations l10n, ThemeData theme) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: [
              theme.colorScheme.primaryContainer.withOpacity(0.1),
              theme.colorScheme.secondaryContainer.withOpacity(0.05),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.all(AppSpacing.spaceXL),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.welcome,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spaceS),
                    Text(
                      l10n.welcomeToDashboard,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spaceL),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: theme.colorScheme.onPrimary,
                                  ),
                                  const SizedBox(width: AppSpacing.spaceS),
                                  Text(l10n.success),
                                ],
                              ),
                              backgroundColor: theme.colorScheme.primary,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        icon: const Icon(Icons.rocket_launch),
                        label: Text(l10n.testAction),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.spaceL),
              Expanded(
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppSpacing.spaceS),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.dashboard_customize,
                      size: 60,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Statistics section with metric cards
  Widget _buildStatsSection(BuildContext context, AppLocalizations l10n, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.statisticsOverview,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppSpacing.spaceL),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: AppSpacing.spaceL,
          crossAxisSpacing: AppSpacing.spaceL,
          childAspectRatio: 1.2,
          children: [
            _buildStatCard(
              context: context,
              theme: theme,
              icon: Icons.people_outline,
              title: l10n.totalUsers,
              value: l10n.usersCount,
              change: l10n.changePositive12,
              isPositive: true,
            ),
            _buildStatCard(
              context: context,
              theme: theme,
              icon: Icons.trending_up,
              title: l10n.revenue,
              value: l10n.revenueAmount,
              change: l10n.changePositive8,
              isPositive: true,
            ),
            _buildStatCard(
              context: context,
              theme: theme,
              icon: Icons.task_alt,
              title: l10n.tasks,
              value: l10n.tasksCount,
              change: l10n.changeNegative3,
              isPositive: false,
            ),
            _buildStatCard(
              context: context,
              theme: theme,
              icon: Icons.bar_chart,
              title: l10n.growth,
              value: l10n.growthPercentage,
              change: l10n.changePositive15,
              isPositive: true,
            ),
          ],
        ),
      ],
    );
  }

  /// Individual stat card widget
  Widget _buildStatCard({
    required BuildContext context,
    required ThemeData theme,
    required IconData icon,
    required String title,
    required String value,
    required String change,
    required bool isPositive,
  }) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsetsDirectional.all(AppSpacing.spaceL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsetsDirectional.all(AppSpacing.spaceS),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(AppSpacing.spaceS),
                  ),
                  child: Icon(
                    icon,
                    size: 24,
                    color: theme.colorScheme.primary,
                  ),
                ),
                Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.spaceS,
                    vertical: AppSpacing.spaceXS,
                  ),
                  decoration: BoxDecoration(
                    color: isPositive 
                        ? theme.colorScheme.primaryContainer.withOpacity(0.2)
                        : theme.colorScheme.errorContainer.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(AppSpacing.spaceM),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                        size: 12,
                        color: isPositive 
                            ? theme.colorScheme.primary
                            : theme.colorScheme.error,
                      ),
                      const SizedBox(width: AppSpacing.spaceXXS),
                      Text(
                        change,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: isPositive 
                              ? theme.colorScheme.primary
                              : theme.colorScheme.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.spaceS),
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            Text(
              title,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Quick actions section with action buttons
  Widget _buildQuickActionsSection(BuildContext context, AppLocalizations l10n, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.quickActions,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppSpacing.spaceL),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: AppSpacing.spaceL,
          crossAxisSpacing: AppSpacing.spaceL,
          childAspectRatio: 1.5,
          children: [
            _buildQuickActionCard(
              context: context,
              theme: theme,
              icon: Icons.post_add,
              title: l10n.createPost,
              subtitle: l10n.addNewContent,
              onTap: () => _handleQuickAction(context, l10n.createPost),
            ),
            _buildQuickActionCard(
              context: context,
              theme: theme,
              icon: Icons.group_add,
              title: l10n.manageUsers,
              subtitle: l10n.userAdministration,
              onTap: () => _handleQuickAction(context, l10n.manageUsers),
            ),
            _buildQuickActionCard(
              context: context,
              theme: theme,
              icon: Icons.analytics,
              title: l10n.viewReports,
              subtitle: l10n.analyticsInsights,
              onTap: () => _handleQuickAction(context, l10n.viewReports),
            ),
            _buildQuickActionCard(
              context: context,
              theme: theme,
              icon: Icons.settings,
              title: l10n.settings,
              subtitle: l10n.appConfiguration,
              onTap: () => _handleQuickAction(context, l10n.settings),
            ),
          ],
        ),
      ],
    );
  }

  /// Individual quick action card widget
  Widget _buildQuickActionCard({
    required BuildContext context,
    required ThemeData theme,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsetsDirectional.all(AppSpacing.spaceL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsetsDirectional.all(AppSpacing.spaceS),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(AppSpacing.spaceS),
                ),
                child: Icon(
                  icon,
                  size: 24,
                  color: theme.colorScheme.secondary,
                ),
              ),
              const SizedBox(height: AppSpacing.spaceS),
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleQuickAction(BuildContext context, String action) {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.actionTapped(action)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}