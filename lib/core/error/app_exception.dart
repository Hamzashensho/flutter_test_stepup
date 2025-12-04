abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException({required this.message, this.statusCode});
}

class ServerException extends AppException {
  const ServerException({required String message, int? statusCode})
      : super(message: message, statusCode: statusCode);
}

class CacheException extends AppException {
  const CacheException({required String message}) : super(message: message);
}

class NetworkException extends AppException {
  const NetworkException({required String message}) : super(message: message);
}