/// Post model representing a JSON placeholder post
/// Used for displaying blog posts and articles in the explore section
class Post {
  /// Unique identifier for the post
  final int id;
  
  /// User ID who created the post
  final int userId;
  
  /// Title of the post
  final String title;
  
  /// Body content of the post
  final String body;

  /// Creates a new Post instance
  const Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  /// Creates a Post from JSON data
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  /// Converts Post to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }

  /// Creates a copy of this Post with updated fields
  Post copyWith({
    int? id,
    int? userId,
    String? title,
    String? body,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Post &&
        other.id == id &&
        other.userId == userId &&
        other.title == title &&
        other.body == body;
  }

  @override
  int get hashCode {
    return Object.hash(id, userId, title, body);
  }

  @override
  String toString() {
    return 'Post(id: $id, userId: $userId, title: $title, body: $body)';
  }
}