import 'package:dio/dio.dart';
import 'package:frontend/models/models.dart';

sealed class AppException implements Exception {
  AppException() : stackTrace = StackTrace.current;

  final StackTrace stackTrace;
}

final class UnknownException extends AppException {
  UnknownException(this.e);

  final Object e;
}

final class HttpClientException extends AppException {
  HttpClientException(this.e);

  final DioException e;
}

final class UnexpectedResponseException extends AppException {
  UnexpectedResponseException(this.e);

  final TypeError e;
}

final class JsonDecodingException extends AppException {}

final class ApiException extends AppException {
  ApiException(this.error);

  final ApiError error;
}
