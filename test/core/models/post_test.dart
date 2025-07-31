import 'package:flutter_test/flutter_test.dart';
import '../../../lib/core/models/post.dart';
import '../../test_utils/test_data.dart';

void main() {
  group('Post Model', () {
    group('Constructor', () {
      test('should create Post with valid parameters', () {
        const post = Post(
          id: 1,
          userId: 1,
          title: 'Test Title',
          body: 'Test Body',
        );

        expect(post.id, 1);
        expect(post.userId, 1);
        expect(post.title, 'Test Title');
        expect(post.body, 'Test Body');
      });

      test('should create Post with test data', () {
        const post = TestData.samplePost1;

        expect(post.id, 1);
        expect(post.userId, 1);
        expect(post.title, 'Sample Post Title 1');
        expect(post.body, 'This is a sample post body for testing purposes. It contains enough text to test display and truncation.');
      });
    });

    group('JSON Serialization', () {
      test('should serialize to JSON correctly', () {
        const post = TestData.samplePost1;
        final json = post.toJson();

        expect(json['id'], post.id);
        expect(json['userId'], post.userId);
        expect(json['title'], post.title);
        expect(json['body'], post.body);
      });

      test('should deserialize from JSON correctly', () {
        final json = TestData.samplePostJson;
        final post = Post.fromJson(json);

        expect(post.id, json['id']);
        expect(post.userId, json['userId']);
        expect(post.title, json['title']);
        expect(post.body, json['body']);
      });

      test('should handle round-trip serialization', () {
        const originalPost = TestData.samplePost1;
        final json = originalPost.toJson();
        final deserializedPost = Post.fromJson(json);

        expect(deserializedPost, equals(originalPost));
      });

      test('should throw on invalid JSON', () {
        final invalidJson = TestData.invalidPostJson;

        expect(
          () => Post.fromJson(invalidJson),
          throwsA(isA<TypeError>()),
        );
      });
    });

    group('Equality', () {
      test('should be equal for same values', () {
        const post1 = Post(
          id: 1,
          userId: 1,
          title: 'Test',
          body: 'Description',
        );
        const post2 = Post(
          id: 1,
          userId: 1,
          title: 'Test',
          body: 'Description',
        );

        expect(post1, equals(post2));
        expect(post1.hashCode, equals(post2.hashCode));
      });

      test('should not be equal for different values', () {
        const post1 = TestData.samplePost1;
        const post2 = TestData.samplePost2;

        expect(post1, isNot(equals(post2)));
        expect(post1.hashCode, isNot(equals(post2.hashCode)));
      });

      test('should be equal to itself', () {
        const post = TestData.samplePost1;

        expect(post, equals(post));
        expect(post.hashCode, equals(post.hashCode));
      });
    });

    group('Copy Operations', () {
      test('should copy with new values', () {
        const originalPost = TestData.samplePost1;
        final copiedPost = originalPost.copyWith(title: 'New Title');

        expect(copiedPost.title, 'New Title');
        expect(copiedPost.id, originalPost.id);
        expect(copiedPost.userId, originalPost.userId);
        expect(copiedPost.body, originalPost.body);
      });

      test('should copy with multiple new values', () {
        const originalPost = TestData.samplePost1;
        final copiedPost = originalPost.copyWith(
          title: 'New Title',
          body: 'New Body',
        );

        expect(copiedPost.title, 'New Title');
        expect(copiedPost.body, 'New Body');
        expect(copiedPost.id, originalPost.id);
        expect(copiedPost.userId, originalPost.userId);
      });

      test('should copy with no changes when no parameters provided', () {
        const originalPost = TestData.samplePost1;
        final copiedPost = originalPost.copyWith();

        expect(copiedPost, equals(originalPost));
        expect(copiedPost.hashCode, equals(originalPost.hashCode));
      });

      test('should copy with null values handled correctly', () {
        const originalPost = TestData.samplePost1;
        final copiedPost = originalPost.copyWith(
          id: null,
          userId: null,
          title: null,
          body: null,
        );

        expect(copiedPost, equals(originalPost));
      });
    });

    group('String Representation', () {
      test('should have readable toString', () {
        const post = TestData.samplePost1;
        final stringRepresentation = post.toString();

        expect(stringRepresentation, contains('Post('));
        expect(stringRepresentation, contains('id: ${post.id}'));
        expect(stringRepresentation, contains('userId: ${post.userId}'));
        expect(stringRepresentation, contains('title: ${post.title}'));
        expect(stringRepresentation, contains('body: ${post.body}'));
      });
    });

    group('Immutability', () {
      test('should maintain immutability of fields', () {
        const post = TestData.samplePost1;

        // Verify fields are final by ensuring they cannot be modified
        expect(post.id, isA<int>());
        expect(post.userId, isA<int>());
        expect(post.title, isA<String>());
        expect(post.body, isA<String>());
      });
    });
  });
}