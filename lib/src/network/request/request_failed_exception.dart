import 'package:dio/dio.dart';

class RequestFailedException implements Exception {
  RequestFailedException(Response response)
      : message = 'Status ${response.statusCode} Body: ${response.data}';

  final String message;

  @override
  String toString() {
    return message;
  }
}
