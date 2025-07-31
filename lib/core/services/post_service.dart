import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/post.dart';
import '../exceptions/api_exception.dart';

/// Service for handling Post API operations
/// Provides methods to fetch posts from JSON Placeholder API
class PostService {
  PostService._(); // Prevent instantiation

  /// Base URL for JSON Placeholder API
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  
  /// Request timeout duration
  static const Duration _timeout = Duration(seconds: 10);

  /// Fetches all posts from the API
  /// Returns a list of Post objects
  /// Throws ApiException on network or parsing errors
  static Future<List<Post>> fetchPosts() async {
    try {
      final uri = Uri.parse('$_baseUrl/posts');
      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      ).timeout(_timeout);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body) as List<dynamic>;
        return jsonList.map((json) => Post.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw ApiException(
          message: 'Failed to load posts',
          statusCode: response.statusCode,
          details: response.body,
        );
      }
    } on TimeoutException {
      throw const ApiException(
        message: 'Request timeout while loading posts',
        details: 'The server took too long to respond',
      );
    } on SocketException {
      throw const ApiException(
        message: 'Network error while loading posts',
        details: 'Please check your internet connection',
      );
    } on FormatException catch (e) {
      throw ApiException(
        message: 'Invalid response format',
        details: e.message,
      );
    } catch (e) {
      throw ApiException(
        message: 'Unexpected error occurred',
        details: e.toString(),
      );
    }
  }

  /// Fetches a single post by ID
  /// Returns a Post object
  /// Throws ApiException on network or parsing errors
  static Future<Post> fetchPost(int id) async {
    try {
      final uri = Uri.parse('$_baseUrl/posts/$id');
      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      ).timeout(_timeout);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body) as Map<String, dynamic>;
        return Post.fromJson(json);
      } else if (response.statusCode == 404) {
        throw ApiException(
          message: 'Post not found',
          statusCode: response.statusCode,
          details: 'Post with ID $id does not exist',
        );
      } else {
        throw ApiException(
          message: 'Failed to load post',
          statusCode: response.statusCode,
          details: response.body,
        );
      }
    } on TimeoutException {
      throw const ApiException(
        message: 'Request timeout while loading post',
        details: 'The server took too long to respond',
      );
    } on SocketException {
      throw const ApiException(
        message: 'Network error while loading post',
        details: 'Please check your internet connection',
      );
    } on FormatException catch (e) {
      throw ApiException(
        message: 'Invalid response format',
        details: e.message,
      );
    } catch (e) {
      throw ApiException(
        message: 'Unexpected error occurred',
        details: e.toString(),
      );
    }
  }
}