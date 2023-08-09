import 'package:quitanda_virtual/src/constants/endpoints.dart';
import 'package:quitanda_virtual/src/models/user_model.dart';
import 'package:quitanda_virtual/src/pages/auth/result/auth_errors.dart'
    as authErrors;
import 'package:quitanda_virtual/src/pages/auth/result/auth_result.dart';
import 'package:quitanda_virtual/src/services/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  AuthResult handleUserOrError(Map<dynamic, dynamic> result) {
    if (result['result'] != null) {
      // final user = UserModel.fromMap(result['result']);
      final user = UserModel.fromJson(result['result']);
      return AuthResult.success(user);
    } else {
      return AuthResult.error(authErrors.authErrorsString(result['error']));
    }
  }

  Future<AuthResult> validateToken(String token) async {
    final result =
        await _httpManager.restRequest(url: Endpoints.validateToken, headers: {
      'X-Parse-Session-Token': token,
    });
    return handleUserOrError(result);
  }

  Future<AuthResult> signIn(
      {required String email, required String password}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signin,
      body: {
        "email": email.toLowerCase(),
        "password": password,
      },
    );
    return handleUserOrError(result);
  }

  Future<AuthResult> signUp(UserModel user) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signup,
      body: user.toJson(),
    );
    return handleUserOrError(result);
  }

  Future<void> resetPassword(String email) async {
    await _httpManager.restRequest(
      url: Endpoints.resetPassword,
      body: {'email': email},
    );
  }
}
