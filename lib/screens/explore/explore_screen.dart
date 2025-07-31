import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/l10n/generated/app_localizations.dart';
import '../../core/constants/spacing.dart';
import '../../core/providers/post_provider.dart';
import '../../core/models/post.dart';

/// Explore screen for discovering health content and insights
/// Shows latest posts from JSON Placeholder API
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostProvider()..loadPosts(),
      child: const _ExploreScreenContent(),
    );
  }
}

class _ExploreScreenContent extends StatelessWidget {
  const _ExploreScreenContent();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLowest,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.all(AppSpacing.spaceL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with refresh button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.explore,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  Consumer<PostProvider>(
                    builder: (context, provider, child) {
                      return IconButton(
                        onPressed: provider.isLoading ? null : () => provider.refreshPosts(),
                        icon: provider.isLoading
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    theme.colorScheme.primary,
                                  ),
                                ),
                              )
                            : Icon(
                                Icons.refresh,
                                color: theme.colorScheme.primary,
                              ),
                        tooltip: l10n.refreshPosts,
                        style: IconButton.styleFrom(
                          backgroundColor: theme.colorScheme.primaryContainer.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSpacing.spaceM),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              
              const SizedBox(height: AppSpacing.spaceM),
              
              // Posts section title
              Text(
                l10n.explorePostsTitle,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              
              const SizedBox(height: AppSpacing.spaceL),
              
              // Posts content
              Expanded(
                child: Consumer<PostProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading && !provider.isInitialized) {
                      return _buildLoadingState(context);
                    }
                    
                    if (provider.hasError) {
                      return _buildErrorState(context, provider);
                    }
                    
                    if (provider.isEmpty) {
                      return _buildEmptyState(context);
                    }
                    
                    return _buildPostsListWithLoader(context, provider);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: AppSpacing.spaceL),
          Text(
            l10n.loadingPosts,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, PostProvider provider) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: theme.colorScheme.error,
          ),
          const SizedBox(height: AppSpacing.spaceL),
          Text(
            l10n.errorLoadingPosts,
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
          const SizedBox(height: AppSpacing.spaceS),
          Text(
            provider.error ?? '',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.spaceXL),
          ElevatedButton(
            onPressed: () => provider.loadPosts(),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
            ),
            child: Text(l10n.retryLoadingPosts),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.article_outlined,
            size: 64,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: AppSpacing.spaceL),
          Text(
            l10n.noPostsFound,
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostsListWithLoader(BuildContext context, PostProvider provider) {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () => provider.refreshPosts(),
          child: ListView.builder(
            itemCount: provider.itemCount,
            itemBuilder: (context, index) {
              final post = provider.posts[index];
              return _buildPostCard(context, post);
            },
          ),
        ),
        
        // Loading overlay during refresh
        if (provider.isLoading && provider.isInitialized)
          _buildRefreshLoadingOverlay(context),
      ],
    );
  }

  Widget _buildRefreshLoadingOverlay(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.spaceM,
          horizontal: AppSpacing.spaceL,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.95),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(AppSpacing.spaceL),
            bottomRight: Radius.circular(AppSpacing.spaceL),
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withOpacity(0.1),
              blurRadius: AppSpacing.spaceS,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.spaceM),
            Text(
              l10n.loadingPosts,
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, Post post) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    return Container(
      margin: const EdgeInsetsDirectional.only(
        bottom: AppSpacing.spaceL,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.spaceL),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.surface,
            theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.1),
            blurRadius: AppSpacing.spaceM,
            offset: const Offset(0, AppSpacing.spaceXS),
          ),
        ],
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSpacing.spaceL),
          onTap: () {
            // Future: Navigate to post detail screen
          },
          child: Padding(
            padding: const EdgeInsetsDirectional.all(AppSpacing.spaceL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with post ID and author
                Row(
                  children: [
                    // Post ID badge
                    Container(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: AppSpacing.spaceM,
                        vertical: AppSpacing.spaceXS,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(AppSpacing.spaceXXL),
                      ),
                      child: Text(
                        '#${post.id}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    
                    const SizedBox(width: AppSpacing.spaceM),
                    
                    // Author info with icon
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.person_outline,
                            size: AppSpacing.spaceL,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: AppSpacing.spaceS),
                          Expanded(
                            child: Text(
                              l10n.postAuthor(post.userId),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: AppSpacing.spaceL),
                
                // Post title with enhanced styling
                Container(
                  width: double.infinity,
                  padding: const EdgeInsetsDirectional.only(
                    bottom: AppSpacing.spaceS,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: theme.colorScheme.primary.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    post.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                      height: 1.3,
                    ),
                  ),
                ),
                
                const SizedBox(height: AppSpacing.spaceL),
                
                // Post body with improved readability
                Container(
                  padding: const EdgeInsetsDirectional.all(AppSpacing.spaceM),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(AppSpacing.spaceM),
                    border: Border.all(
                      color: theme.colorScheme.outline.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    post.body,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                      height: 1.5,
                      letterSpacing: 0.2,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                
                const SizedBox(height: AppSpacing.spaceL),
                
                // Action row with read more indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Article icon
                    Container(
                      padding: const EdgeInsetsDirectional.all(AppSpacing.spaceS),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondaryContainer.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(AppSpacing.spaceS),
                      ),
                      child: Icon(
                        Icons.article_outlined,
                        size: AppSpacing.spaceL,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                    ),
                    
                    // Read more indicator
                    Row(
                      children: [
                        Text(
                          l10n.readMore,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.spaceXS),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: AppSpacing.spaceM,
                          color: theme.colorScheme.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}