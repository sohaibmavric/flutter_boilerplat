import 'package:flutter/foundation.dart';
import '../models/post.dart';
import '../services/post_service.dart';
import '../exceptions/api_exception.dart';

/// Provider for managing Post state and operations
/// Handles loading, error states, and post data management
class PostProvider extends ChangeNotifier {
  // Private state variables
  List<Post> _posts = [];
  bool _isLoading = false;
  String? _error;
  bool _isInitialized = false;

  // Public getters
  /// List of posts (immutable)
  List<Post> get posts => List.unmodifiable(_posts);
  
  /// Loading state indicator
  bool get isLoading => _isLoading;
  
  /// Error message if any
  String? get error => _error;
  
  /// Whether the provider has been initialized
  bool get isInitialized => _isInitialized;
  
  /// Whether the posts list is empty
  bool get isEmpty => _posts.isEmpty;
  
  /// Whether there are posts available
  bool get hasData => _posts.isNotEmpty;
  
  /// Whether there is an error
  bool get hasError => _error != null;
  
  /// Number of posts
  int get itemCount => _posts.length;

  /// Loads posts from the API
  /// Sets loading state and handles errors
  Future<void> loadPosts() async {
    await _executeWithLoading(() async {
      final posts = await PostService.fetchPosts();
      _posts = posts;
      _isInitialized = true;
    });
  }

  /// Refreshes posts data
  /// Reloads posts from the API
  Future<void> refreshPosts() async {
    await loadPosts();
  }

  /// Clears the current error state
  void clearError() {
    if (_error != null) {
      _error = null;
      notifyListeners();
    }
  }

  /// Finds a post by ID
  /// Returns null if post is not found
  Post? findPostById(int id) {
    try {
      return _posts.firstWhere((post) => post.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Private helper to execute operations with loading state
  Future<void> _executeWithLoading(Future<void> Function() operation) async {
    _setLoading(true);
    _clearError();
    
    try {
      await operation();
    } on ApiException catch (e) {
      _setError(e.message);
    } catch (e) {
      _setError('An unexpected error occurred');
    } finally {
      _setLoading(false);
    }
  }

  /// Private helper to set loading state
  void _setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }

  /// Private helper to set error state
  void _setError(String message) {
    _error = message;
    notifyListeners();
  }

  /// Private helper to clear error state
  void _clearError() {
    _error = null;
  }

  @override
  void dispose() {
    _posts.clear();
    super.dispose();
  }
}