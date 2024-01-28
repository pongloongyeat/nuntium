import 'package:dart_result_type/dart_result_type.dart';
import 'package:frontend/data/data.dart';
import 'package:frontend/models/models.dart';

final class AuthRepository {
  Future<Result<AuthResponse, AppException>> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    if (email == 'pongloongyeat@gmail.com' && password == 'Testing123!') {
      return Ok(
        AuthResponse(accessToken: 'accessToken', refreshToken: 'refreshToken'),
      );
    }

    return Err(
      ApiException(
        ApiError(
          errorCode: 'Unauthorised',
          message: 'Incorrect email/password',
        ),
      ),
    );
  }
}
