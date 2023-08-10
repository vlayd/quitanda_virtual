import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda_virtual/src/constants/storage_keys.dart';
import 'package:quitanda_virtual/src/models/user_model.dart';
import 'package:quitanda_virtual/src/pages/auth/repository/auth_repository.dart';
import 'package:quitanda_virtual/src/pages/auth/result/auth_result.dart';
import 'package:quitanda_virtual/src/pages_routes/app_pages.dart';
import 'package:quitanda_virtual/src/services/utils_services.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  final authRepository = AuthRepository();
  final utilsServices = UtilsServices();
  UserModel user = UserModel();

  @override
  void onInit() {
    //TODO sempre é chamado a class que herda o GetxController
    super.onInit();
    validateToken();
  }

  Future<void> validateToken() async {
    //recuperar token localmente
    String? token = await utilsServices.getLocalData(key: StorageKeys.token);
    if (token == null) {
      Get.offAllNamed(PagesRoutes.signInRoute);
      return;
    }
    AuthResult result = await authRepository.validateToken(token);
    result.when(success: (user) {
      this.user = user;
      saveTokenAndProceedToBase();
    }, error: (message) {
      signOut();
    });
  }

  Future<void> signOut() async {
    // Zerar o user
    user = UserModel();
    // Remover o token localmente
    await utilsServices.removeLocalData(key: StorageKeys.token);
    // Ir para o login
    Get.offAllNamed(PagesRoutes.signInRoute);
  }

  Future<void> resetPassword(String email) async {
    await authRepository.resetPassword(email);
  }

  void saveTokenAndProceedToBase() {
    // Salvar o token
    utilsServices.saveLocalData(key: StorageKeys.token, data: user.token!);

    // Ir para a base
    Get.offAllNamed(PagesRoutes.baseRoute);
  }

  Future<void> signIn({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    isLoading.value = true;
    AuthResult result = await authRepository.signIn(
      email: email,
      password: password,
    );
    isLoading.value = false;
    result.when(success: (user) {
      this.user = user;
      saveTokenAndProceedToBase();
    }, error: (message) {
      utilsServices.showToast(
          message: message, isError: true, context: context);
    });
  }

  Future<void> signUp({BuildContext? context}) async {
    isLoading.value = true;
    AuthResult result = await authRepository.signUp(user);
    isLoading.value = false;
    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (message) {
        utilsServices.showToast(message: message, context: context);
      },
    );
  }
}
