/// Custom exception for API-related errors
/// Provides specific error information for network and API failures
class ApiException implements Exception {
  /// Error message describing what went wrong
  final String message;
  
  /// HTTP status code if available
  final int? statusCode;
  
  /// Additional error details
  final String? details;

  /// Creates a new ApiException
  const ApiException({
    required this.message,
    this.statusCode,
    this.details,
  });

  @override
  String toString() {
    final buffer = StringBuffer('ApiException: $message');
    if (statusCode != null) {
      buffer.write(' (Status: $statusCode)');
    }
    if (details != null) {
      buffer.write(' - $details');
    }
    return buffer.toString();
  }
}