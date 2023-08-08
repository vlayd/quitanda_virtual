import 'package:quitanda_virtual/src/constants/endpoints.dart';
import 'package:quitanda_virtual/src/models/user_model.dart';
import 'package:quitanda_virtual/src/services/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  Future signIn({required String email, required String password}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signin,
      method: HttpMethods.post,
      body: {
        "email": email.toLowerCase(),
        "password": password,
      },
    );
    if (result['result'] != null) {
      //TODO print("resposta $user") são os dados do toString em UserModel
      final user = UserModel.fromMap(result['result']);
      print("resposta $user");
    } else {
      print("resposta Não funcionou");
    }
  }
}
