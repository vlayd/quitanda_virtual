import 'package:flutter/material.dart';
import 'package:quitanda_virtual/src/pages/auth/view/sign_in_screen.dart';
import 'package:quitanda_virtual/src/services/custom_theme.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.themeData(),
      home: const SignInScreen(),
    ),
  );
}
