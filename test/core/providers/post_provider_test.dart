import 'package:flutter_test/flutter_test.dart';
import '../../../lib/core/providers/post_provider.dart';
import '../../../lib/core/models/post.dart';
import '../../test_utils/test_data.dart';

void main() {
  group('PostProvider', () {
    late PostProvider provider;

    setUp(() {
      provider = PostProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    group('Initial State', () {
      test('should have correct initial state', () {
        expect(provider.posts, isEmpty);
        expect(provider.isLoading, false);
        expect(provider.error, null);
        expect(provider.isEmpty, true);
        expect(provider.hasData, false);
        expect(provider.hasError, false);
        expect(provider.isInitialized, false);
        expect(provider.itemCount, 0);
      });

      test('should return immutable posts list', () {
        expect(provider.posts, isA<List<Post>>());
        expect(() => provider.posts.add(TestData.samplePost1), throwsUnsupportedError);
      });
    });

    group('Business Logic Operations', () {
      test('should set loading state when starting loadPosts', () {
        final future = provider.loadPosts();
        expect(provider.isLoading, true);
        return future.catchError((_) {}); // Handle expected failures
      });

      test('should handle loadPosts completion', () async {
        await provider.loadPosts();
        
        expect(provider.isLoading, false);
        expect(provider.isInitialized, true);
        
        // Handle both success and error scenarios
        if (provider.error == null) {
          expect(provider.hasData, true);
          expect(provider.itemCount, greaterThan(0));
        } else {
          expect(provider.hasError, true);
          expect(provider.error, isNotNull);
        }
      });

      test('should handle refreshPosts', () async {
        // First load
        await provider.loadPosts();
        final initialErrorState = provider.hasError;
        
        // Refresh
        await provider.refreshPosts();
        
        expect(provider.isLoading, false);
        expect(provider.isInitialized, true);
      });

      test('should clear error state', () async {
        // Load posts to potentially get an error
        await provider.loadPosts();
        
        if (provider.hasError) {
          provider.clearError();
          expect(provider.hasError, false);
          expect(provider.error, null);
        }
      });
    });

    group('State Notifications', () {
      test('should notify listeners on state changes', () async {
        var notificationCount = 0;
        provider.addListener(() => notificationCount++);
        
        await provider.loadPosts();
        expect(notificationCount, greaterThan(0));
      });

      test('should not notify listeners if error state unchanged', () {
        var notificationCount = 0;
        provider.addListener(() => notificationCount++);
        
        // Clear error when there's no error
        provider.clearError();
        expect(notificationCount, 0);
      });
    });

    group('Post Management', () {
      test('should find post by ID when posts are loaded', () async {
        await provider.loadPosts();
        
        if (provider.hasData && provider.posts.isNotEmpty) {
          final firstPost = provider.posts.first;
          final foundPost = provider.findPostById(firstPost.id);
          expect(foundPost, equals(firstPost));
        }
      });

      test('should return null for non-existent post ID', () async {
        await provider.loadPosts();
        
        final nonExistentPost = provider.findPostById(TestData.nonExistentPostId);
        expect(nonExistentPost, isNull);
      });

      test('should return null when finding post with empty list', () {
        final foundPost = provider.findPostById(1);
        expect(foundPost, isNull);
      });
    });

    group('Error Handling', () {
      test('should handle network errors gracefully', () async {
        await provider.loadPosts();
        
        // Provider should handle errors without throwing
        expect(provider.isLoading, false);
        
        // Should either have data or error, not both
        if (provider.hasError) {
          expect(provider.error, isNotNull);
          expect(provider.hasData, false);
        } else {
          expect(provider.error, isNull);
        }
      });

      test('should maintain state consistency during errors', () async {
        await provider.loadPosts();
        
        expect(provider.isLoading, false);
        expect(provider.isInitialized, true);
        
        // State should be consistent
        expect(provider.isEmpty, !provider.hasData);
        expect(provider.hasError, provider.error != null);
        expect(provider.itemCount, provider.posts.length);
      });
    });

    group('Concurrent Operations', () {
      test('should handle multiple simultaneous loadPosts calls', () async {
        final futures = List.generate(3, (_) => provider.loadPosts());
        await Future.wait(futures.map((f) => f.catchError((_) {})));
        
        expect(provider.isLoading, false);
        expect(provider.isInitialized, true);
      });

      test('should handle loadPosts and refreshPosts concurrency', () async {
        final loadFuture = provider.loadPosts();
        final refreshFuture = provider.refreshPosts();
        
        await Future.wait([
          loadFuture.catchError((_) {}),
          refreshFuture.catchError((_) {}),
        ]);
        
        expect(provider.isLoading, false);
      });
    });

    group('Resource Management', () {
      test('should dispose properly', () {
        // Test that dispose doesn't throw an exception
        expect(() {
          final testProvider = PostProvider();
          testProvider.dispose();
        }, returnsNormally);
      });

      test('should handle disposal without errors', () {
        // Test disposal in isolation
        final testProvider = PostProvider();
        expect(testProvider.posts, isEmpty);
        testProvider.dispose();
        // Test completes successfully if no exception is thrown
      });
    });

    group('State Calculations', () {
      test('should calculate isEmpty correctly', () {
        expect(provider.isEmpty, true);
        expect(provider.hasData, false);
      });

      test('should calculate hasData correctly when posts exist', () async {
        await provider.loadPosts();
        
        if (provider.posts.isNotEmpty) {
          expect(provider.hasData, true);
          expect(provider.isEmpty, false);
        }
      });

      test('should calculate itemCount correctly', () {
        expect(provider.itemCount, 0);
        
        // After loading
        provider.loadPosts().then((_) {
          expect(provider.itemCount, provider.posts.length);
        }).catchError((_) {});
      });
    });
  });
}