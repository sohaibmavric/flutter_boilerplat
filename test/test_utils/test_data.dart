import '../../lib/core/models/post.dart';

/// Centralized test data for consistent testing across the application
/// Provides sample data for posts, error scenarios, and edge cases
class TestData {
  TestData._(); // Prevent instantiation

  // Sample Post models
  static const Post samplePost1 = Post(
    id: 1,
    userId: 1,
    title: 'Sample Post Title 1',
    body: 'This is a sample post body for testing purposes. It contains enough text to test display and truncation.',
  );

  static const Post samplePost2 = Post(
    id: 2,
    userId: 2,
    title: 'Sample Post Title 2',
    body: 'Another sample post body with different content for testing various scenarios.',
  );

  static const Post samplePost3 = Post(
    id: 3,
    userId: 1,
    title: 'Sample Post Title 3',
    body: 'Third sample post for testing pagination and large datasets.',
  );

  // Collections
  static const List<Post> samplePostList = [
    samplePost1,
    samplePost2,
    samplePost3,
  ];

  static const List<Post> emptyPostList = <Post>[];

  static const List<Post> singlePostList = [samplePost1];

  // JSON data
  static const Map<String, dynamic> samplePostJson = {
    'id': 1,
    'userId': 1,
    'title': 'Sample Post Title 1',
    'body': 'This is a sample post body for testing purposes. It contains enough text to test display and truncation.',
  };

  static const Map<String, dynamic> invalidPostJson = {
    'id': 'invalid',
    'userId': null,
    'title': 123,
    'body': true,
  };

  static const List<Map<String, dynamic>> samplePostListJson = [
    {
      'id': 1,
      'userId': 1,
      'title': 'Sample Post Title 1',
      'body': 'This is a sample post body for testing purposes.',
    },
    {
      'id': 2,
      'userId': 2,
      'title': 'Sample Post Title 2',
      'body': 'Another sample post body with different content.',
    },
  ];

  // Error messages
  static const String networkErrorMessage = 'Network error while loading posts';
  static const String timeoutErrorMessage = 'Request timeout while loading posts';
  static const String apiErrorMessage = 'Failed to load posts';
  static const String parseErrorMessage = 'Invalid response format';
  static const String unexpectedErrorMessage = 'An unexpected error occurred';

  // API responses
  static const String validApiResponse = '''
[
  {
    "id": 1,
    "userId": 1,
    "title": "Sample Post Title 1",
    "body": "This is a sample post body for testing purposes."
  },
  {
    "id": 2,
    "userId": 2,
    "title": "Sample Post Title 2", 
    "body": "Another sample post body with different content."
  }
]
''';

  static const String invalidApiResponse = '''
{
  "error": "Invalid request"
}
''';

  static const String emptyApiResponse = '[]';

  // Edge case values
  static const int maxPostId = 999999;
  static const int minPostId = 1;
  static const int invalidPostId = -1;
  static const int nonExistentPostId = 999999;
}