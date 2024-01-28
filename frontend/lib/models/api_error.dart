import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend/models/models.dart';

part 'api_error.freezed.dart';
part 'api_error.g.dart';

@freezed
class ApiError with _$ApiError {
  factory ApiError({
    required String errorCode,
    String? message,
    List<ValidationError>? validationErrors,
  }) = _ApiError;

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);
}
