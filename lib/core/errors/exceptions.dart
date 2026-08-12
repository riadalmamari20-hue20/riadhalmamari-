class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalException;

  AppException({
    required this.message,
    this.code,
    this.originalException,
  });

  @override
  String toString() => 'AppException: $message';
}

class DatabaseException extends AppException {
  DatabaseException({
    required String message,
    String? code,
    dynamic originalException,
  }) : super(
    message: message,
    code: code,
    originalException: originalException,
  );
}

class NotFoundException extends AppException {
  NotFoundException({
    required String message,
    String? code,
  }) : super(
    message: message,
    code: code,
  );
}

class ValidationException extends AppException {
  ValidationException({
    required String message,
    String? code,
  }) : super(
    message: message,
    code: code,
  );
}
