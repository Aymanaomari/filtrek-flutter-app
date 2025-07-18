// Custom HTTP Exception class
class HttpException implements Exception {
  final int statusCode;
  final String message;
  final Map<String, dynamic>? responseBody;

  HttpException({
    required this.statusCode,
    required this.message,
    this.responseBody,
  });

  @override
  String toString() {
    return responseBody != null && responseBody!['message'] != null
        ? responseBody!['message']
        : 'HttpException: $statusCode - $message';
  }
}
