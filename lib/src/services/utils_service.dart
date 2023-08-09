import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';

import '../config/custom_colors.dart';

class UtilsServices {
  final storage = const FlutterSecureStorage();

  // Salva dado localmente em segurança
  Future<void> saveLocalData(
      {required String key, required String data}) async {
    await storage.write(key: key, value: data);
  }

  // Recupera dado salvo localmente em segurança
  Future<String?> getLocalData({required String key}) async {
    return await storage.read(key: key);
  }

  // Remove dado salvo localmente
  Future<void> removeLocalData({required String key}) async {
    await storage.delete(key: key);
  }

  String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: "pt_BR");
    return numberFormat.format(price);
  }

  String formatDateTime(DateTime dateTime) {
    initializeDateFormatting();
    //TODO apresentação da hora formato do Brasil
    DateFormat dateFormat = DateFormat.yMd("pt_BR").add_Hm();
    return dateFormat.format(dateTime);
  }

  void showToast(
      {required String message, bool isError = false, required context}) {
    MotionToast(
      icon: Icons.info,
      primaryColor: isError ? Colors.red : CustomColors.customSwatchColor,
      // title: const Text("Custom Toast"),
      description: Text(message),
      width: 200,
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 40),
    ).show(context);
  }
}
