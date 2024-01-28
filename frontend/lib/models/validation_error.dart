import 'package:freezed_annotation/freezed_annotation.dart';

part 'validation_error.freezed.dart';
part 'validation_error.g.dart';

@freezed
class ValidationError with _$ValidationError {
  factory ValidationError({
    required String fieldName,
    required String errorCode,
  }) = _ValidationError;

  factory ValidationError.fromJson(Map<String, dynamic> json) =>
      _$ValidationErrorFromJson(json);
}
