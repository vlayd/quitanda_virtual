import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:quitanda_virtual/src/config/custom_colors.dart';
import 'package:quitanda_virtual/src/pages/auth/controller/auth_controller.dart';
import 'package:quitanda_virtual/src/pages/common_widgets/custom_text_field.dart';
import 'package:quitanda_virtual/src/services/validators.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final phoneFormatter = MaskTextInputFormatter(
    mask: '## # ####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final _formkey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          //TODO stack é widget em cima do outro
          child: Stack(
            children: [
              Column(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Cadastro",
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 40),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(45),
                      ),
                    ),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            icon: Icons.email,
                            label: "E-mail",
                            validator: emailValidator,
                            onSaved: (value) {
                              authController.user.email = value;
                            },
                            textInputType: TextInputType.emailAddress,
                          ),
                          CustomTextField(
                            icon: Icons.lock,
                            label: "Senha",
                            isSecret: true,
                            validator: passwordValidator,
                            onSaved: (value) {
                              authController.user.password = value;
                            },
                          ),
                          CustomTextField(
                            icon: Icons.person,
                            label: "Nome",
                            validator: nameValidator,
                            onSaved: (value) {
                              authController.user.name = value;
                            },
                          ),
                          CustomTextField(
                            icon: Icons.phone,
                            validator: phoneValidator,
                            onSaved: (value) {
                              authController.user.phone = value;
                            },
                            label: "Celular",
                            textInputType: TextInputType.phone,
                            inputFormatters: [phoneFormatter],
                          ),
                          CustomTextField(
                            icon: Icons.file_copy,
                            textInputType: TextInputType.number,
                            validator: cpfValidator,
                            onSaved: (value) {
                              authController.user.cpf = value;
                            },
                            label: "CPF",
                            inputFormatters: [cpfFormatter],
                          ),
                          SizedBox(
                            height: 50,
                            child: Obx(() {
                              return ElevatedButton(
                                onPressed: authController.isLoading.value
                                    ? null
                                    : () {
                                        FocusScope.of(context).unfocus();
                                        //TODO código para validar todos ao mesmo tempo
                                        if (_formkey.currentState!.validate()) {
                                          _formkey.currentState!.save();
                                          authController.signUp(
                                              context: context);
                                        }
                                      },
                                child: authController.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        "Cadastrar Usuário",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 5,
                left: 5,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
