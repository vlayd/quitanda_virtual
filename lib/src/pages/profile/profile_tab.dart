import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda_virtual/src/config/app_data.dart' as appData;
import 'package:quitanda_virtual/src/pages/auth/controller/auth_controller.dart';
import 'package:quitanda_virtual/src/pages/common_widgets/custom_text_field.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final autoController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil do usuário"),
        actions: [
          IconButton(
            onPressed: () {
              autoController.signOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: ListView(
        //TODO scroll com animação de forma a descer o conteúdo bem abaixo
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          CustomTextField(
            readOnly: true,
            icon: Icons.email,
            label: "E-mail",
            initialValue: appData.user.email,
          ),
          CustomTextField(
            readOnly: true,
            icon: Icons.person,
            label: "Nome",
            initialValue: appData.user.name,
          ),
          CustomTextField(
            readOnly: true,
            icon: Icons.phone,
            label: "Celular",
            initialValue: appData.user.phone,
          ),
          CustomTextField(
            readOnly: true,
            icon: Icons.file_copy,
            label: "CPF",
            isSecret: true,
            initialValue: appData.user.cpf,
          ),
          SizedBox(
            height: 50,
            child: OutlinedButton(
              onPressed: () {
                updatePassword();
              },
              child: const Text("Atualizar senha"),
            ),
          )
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        "Atualização de senha",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const CustomTextField(
                      icon: Icons.lock,
                      label: "Senha atual",
                      isSecret: true,
                    ),
                    const CustomTextField(
                      icon: Icons.lock_outline,
                      label: "Nova senha",
                      isSecret: true,
                    ),
                    const CustomTextField(
                      icon: Icons.lock_outline,
                      label: "Confirmar nova senha",
                      isSecret: true,
                    ),
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("Atualizar"),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 12,
                right: 5,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
